import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/edition_summary.dart';
import 'package:proyecto_seminario_alvaro/components/invitation_box.dart';
import 'package:proyecto_seminario_alvaro/components/recommendation_card.dart';
import 'package:proyecto_seminario_alvaro/components/section_button.dart';
import 'package:proyecto_seminario_alvaro/logic/cloning.dart';
import 'package:proyecto_seminario_alvaro/logic/messages.dart';
import 'package:proyecto_seminario_alvaro/logic/recommendations.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/logic/savings.dart';
import 'package:proyecto_seminario_alvaro/logic/tasks.dart';
import 'package:proyecto_seminario_alvaro/logic/templates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/models/recommendation.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// The screen managing an edition with recommendations, lifecycle, and section buttons.
class EditionScreen extends StatefulWidget {
  const EditionScreen({super.key});

  @override
  State<EditionScreen> createState() => _EditionScreenState();
}

class _EditionScreenState extends State<EditionScreen> {
  late EventSeries _series;
  late Edition _edition;
  bool _initialized = false;
  String? _shownInvitation;
  List<String>? _shownEmails;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments as EditionArgs;
      _series = args.series;
      _edition = args.edition;
      _initialized = true;
    }
  }

  void _publish() {
    if (!canPublish(_edition, DateTime.now())) {
      setState(() {
        _error = 'Para publicar, la fecha debe ser posterior a hoy';
      });
      return;
    }

    setState(() {
      _edition = _edition.copyWith(status: 'published');
      _error = null;
    });
  }

  void _close() {
    setState(() {
      _edition = _edition.copyWith(status: 'closed');
      _error = null;
    });
  }

  void _acceptRecommendation(Recommendation rec) {
    if (rec.rule == 'R4') {
      final inv = _edition.messages
          .where((m) => m.type == 'invitation')
          .firstOrNull;
      if (inv != null) {
        final values = messageValues(_series, _edition);
        _shownInvitation = fillTemplate(inv.body, values);
      } else {
        _shownInvitation =
            'Esta edición no tiene mensaje de invitación. Agrégalo en Mensajes.';
      }
      _shownEmails = rec.people.map((p) => p.split(' · ').last).toList();
    }

    setState(() {
      _edition = acceptRecommendation(_edition, rec, DateTime.now());
    });
  }

  void _discardRecommendation(Recommendation rec) {
    setState(() {
      _edition = discardRecommendation(_edition, rec, DateTime.now());
    });
  }

  void _hideInvitation() {
    setState(() {
      _shownInvitation = null;
      _shownEmails = null;
    });
  }

  Future<void> _openSection(String route) async {
    final updated = await Navigator.pushNamed(
      context,
      route,
      arguments: EditionArgs(series: _series, edition: _edition),
    );

    if (updated is Edition && mounted) {
      setState(() {
        _edition = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    final today = DateTime.now();
    final history = historyFor(_series, _edition);
    final recs = _edition.status == 'closed'
        ? <Recommendation>[]
        : buildRecommendations(_series, _edition);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_series.name} · Edición ${_edition.number}'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _edition),
        ),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditionSummary(
              inscritos: _edition.registrations.length,
              cupo: _edition.quota,
              capacidad: _edition.capacity,
              reusedPercent: reusedPercent(_edition),
              estado: _edition.status,
            ),
            const SizedBox(height: 16),
            if (_edition.status == 'draft') ...[
              FilledButton.icon(
                onPressed: _publish,
                icon: const Icon(Icons.publish),
                label: const Text('Publicar edición'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              const SizedBox(height: 16),
            ] else if (_edition.status == 'published') ...[
              OutlinedButton.icon(
                onPressed: _close,
                icon: const Icon(Icons.lock_outline),
                label: const Text('Cerrar edición'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.closed,
                ),
              ),
              const SizedBox(height: 16),
            ] else ...[
              Text(
                'Edición cerrada: solo lectura. Cuenta como historial para las recomendaciones.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (_shownInvitation != null) ...[
              InvitationBox(
                text: _shownInvitation!,
                emails: _shownEmails ?? [],
                onClose: _hideInvitation,
              ),
              const SizedBox(height: 16),
            ],
            if (_edition.status != 'closed') ...[
              Text('Recomendaciones', style: textTheme.titleLarge),
              const SizedBox(height: 12),
              if (history.length < 2)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Se necesitan 2 ediciones cerradas para recomendar. Esta serie tiene ${history.length}.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ),
                )
              else if (recs.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Sin recomendaciones: esta edición ya recoge lo aprendido.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ),
                )
              else
                for (final r in recs)
                  RecommendationCard(
                    recommendation: r,
                    onAccept: () => _acceptRecommendation(r),
                    onDiscard: () => _discardRecommendation(r),
                  ),
              const SizedBox(height: 20),
            ],
            Text('Detalles de la edición', style: textTheme.titleLarge),
            const SizedBox(height: 12),
            SectionButton(
              icon: Icons.description_outlined,
              title: 'Formulario de inscripción',
              detail: '${_edition.fields.length} preguntas',
              onTap: () => _openSection('/editions/form'),
            ),
            SectionButton(
              icon: Icons.message_outlined,
              title: 'Mensajes',
              detail:
                  '${sentCount(_edition)} de ${_edition.messages.length} enviados',
              onTap: () => _openSection('/editions/messages'),
            ),
            SectionButton(
              icon: Icons.checklist_outlined,
              title: 'Tareas',
              detail: tasksSummary(_edition, today),
              onTap: () => _openSection('/editions/tasks'),
            ),
            SectionButton(
              icon: Icons.people_outline,
              title: 'Registro de asistencia',
              detail:
                  '${attendedCount(_edition)} de ${_edition.registrations.length} asistieron',
              onTap: () => _openSection('/editions/attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
