import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/edition_summary.dart';
import 'package:proyecto_seminario_alvaro/components/recommendation_card.dart';
import 'package:proyecto_seminario_alvaro/components/section_button.dart';
import 'package:proyecto_seminario_alvaro/logic/cloning.dart';
import 'package:proyecto_seminario_alvaro/logic/recommendations.dart';
import 'package:proyecto_seminario_alvaro/logic/savings.dart';
import 'package:proyecto_seminario_alvaro/logic/templates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/models/recommendation.dart';

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

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final history = historyFor(_series, _edition);
    final recs = _edition.status == 'closed'
        ? <Recommendation>[]
        : buildRecommendations(_series, _edition);

    final attendedCount =
        _edition.registrations.where((r) => r.attended).length;

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
                  style: TextStyle(
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
                  foregroundColor: const Color(0xFF454C61),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (_shownInvitation != null) ...[
              Card(
                color: const Color(0xFFFFF3DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFF0C572)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Invitación para frecuentes',
                            style: TextStyle(
                              color: Color(0xFFA96C05),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () {
                              setState(() {
                                _shownInvitation = null;
                                _shownEmails = null;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        _shownInvitation!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      if (_shownEmails != null && _shownEmails!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Destinatarios:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          _shownEmails!.join(', '),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (_edition.status != 'closed') ...[
              Text(
                'Recomendaciones',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              if (history.length < 2)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Se necesitan 2 ediciones cerradas para recomendar. Esta serie tiene ${history.length}.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
            Text(
              'Detalles de la edición',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SectionButton(
              icon: Icons.description_outlined,
              title: 'Formulario de inscripción',
              detail: '${_edition.fields.length} preguntas',
              onTap: () {},
            ),
            SectionButton(
              icon: Icons.message_outlined,
              title: 'Mensajes',
              detail: '${_edition.messages.length} mensajes',
              onTap: () {},
            ),
            SectionButton(
              icon: Icons.checklist_outlined,
              title: 'Tareas',
              detail: '${_edition.tasks.length} tareas',
              onTap: () {},
            ),
            SectionButton(
              icon: Icons.people_outline,
              title: 'Registro de asistencia',
              detail: '$attendedCount de ${_edition.registrations.length} asistieron',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
