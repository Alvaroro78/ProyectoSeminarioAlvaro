import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/field_card.dart';
import 'package:proyecto_seminario_alvaro/components/field_form.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/logic/savings.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Screen to add and remove the questions of an edition's registration form.
class FormBuilderScreen extends StatefulWidget {
  const FormBuilderScreen({super.key});

  @override
  State<FormBuilderScreen> createState() => _FormBuilderScreenState();
}

class _FormBuilderScreenState extends State<FormBuilderScreen> {
  late Edition _edition;
  bool _initialized = false;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments as EditionArgs;
      _edition = args.edition;
      _initialized = true;
    }
  }

  bool get _canEdit => _edition.status != 'closed';

  void _addField(RegistrationField field) {
    setState(() {
      _edition = _edition.copyWith(
        fields: [
          ..._edition.fields,
          field.copyWith(order: _edition.fields.length + 1),
        ],
      );
      _error = null;
    });
  }

  void _deleteField(RegistrationField field) {
    if (answersCount(_edition, field.id) > 0) {
      setState(() {
        _error = 'Esta pregunta ya tiene respuestas y no se puede quitar';
      });
      return;
    }
    final remaining = _edition.fields.where((f) => f.id != field.id).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    setState(() {
      _edition = _edition.copyWith(
        fields: [
          for (var i = 0; i < remaining.length; i++)
            remaining[i].copyWith(order: i + 1),
        ],
      );
      _error = null;
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
    final fields = [..._edition.fields]
      ..sort((a, b) => a.order.compareTo(b.order));

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario · Edición ${_edition.number}'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _edition),
        ),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${reusedPercent(_edition)} % reutilizado',
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            if (!_canEdit) ...[
              Text(
                'Edición cerrada: solo lectura.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (_error != null) ...[
              Text(
                _error!,
                style: textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (fields.isEmpty)
              const EmptyMessage(
                text:
                    'Este formulario no tiene preguntas: el invitado solo confirma su inscripción.',
              )
            else
              for (final field in fields)
                FieldCard(
                  field: field,
                  answersCount: answersCount(_edition, field.id),
                  canEdit: _canEdit,
                  onDelete: () => _deleteField(field),
                ),
            if (_canEdit) ...[
              const SizedBox(height: 16),
              FieldForm(
                existingLabels: _edition.fields.map((f) => f.label).toList(),
                onAdd: (field) => _addField(field),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
