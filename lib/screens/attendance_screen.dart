import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/attendee_card.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Screen to find registered people by name or code and mark attendance.
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final _searchController = TextEditingController();
  late Edition _edition;
  bool _initialized = false;
  String _query = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments as EditionArgs;
      _edition = args.edition;
      _initialized = true;
    }
  }

  bool get _canEdit => _edition.status == 'published';

  void _toggleAttended(Registration registration) {
    setState(() {
      _edition = _edition.copyWith(
        registrations: [
          for (final r in _edition.registrations)
            r.id == registration.id ? r.copyWith(attended: !r.attended) : r,
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    final results = searchRegistrations(_edition.registrations, _query);

    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencia · Edición ${_edition.number}'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _edition),
        ),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${attendedCount(_edition)} de ${_edition.registrations.length} asistieron',
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            if (!_canEdit) ...[
              Text(
                _edition.status == 'closed'
                    ? 'Edición cerrada: la asistencia no se puede cambiar.'
                    : 'La asistencia se marca cuando la edición está publicada.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                hintText: 'Busca por nombre o código',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (_edition.registrations.isEmpty)
              const EmptyMessage(text: 'Nadie se ha inscrito todavía.')
            else if (results.isEmpty)
              EmptyMessage(text: 'Nadie coincide con «$_query»')
            else
              for (final registration in results)
                AttendeeCard(
                  registration: registration,
                  canEdit: _canEdit,
                  onToggleAttended: () => _toggleAttended(registration),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
