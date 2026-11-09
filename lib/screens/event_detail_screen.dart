import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/registration_form.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Screen with an event's details and its registration form.
class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventArgs;
    final series = args.series;
    final edition = args.edition;
    final textTheme = Theme.of(context).textTheme;
    final registration = edition.registrations
        .where((r) => r.userId == args.user.id)
        .firstOrNull;
    final spots = freeSpots(edition);

    Widget action;
    if (registration != null) {
      action = Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Ya estás inscrito · ${registration.code}',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.published,
            ),
          ),
        ),
      );
    } else if (spots <= 0) {
      action = const FilledButton(
        onPressed: null,
        child: Text('Sin cupos'),
      );
    } else {
      action = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Text('Inscríbete', style: textTheme.titleLarge),
          RegistrationForm(
            fields: edition.fields,
            onSubmit: (answers) => Navigator.pop(context, answers),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${series.name} · Edición ${edition.number}'),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      '${series.name} · Edición ${edition.number}',
                      style: textTheme.titleMedium,
                    ),
                    if (series.description.isNotEmpty)
                      Text(
                        series.description,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.mutedText,
                        ),
                      ),
                    Text(
                      '${formatDate(edition.dateTime)} · ${formatTime(edition.dateTime)}',
                      style: textTheme.bodyMedium,
                    ),
                    Text(edition.place, style: textTheme.bodyMedium),
                    Text(
                      spots > 0 ? 'Quedan $spots cupos' : 'Sin cupos',
                      style: textTheme.labelLarge?.copyWith(
                        color:
                            spots > 0 ? AppColors.published : AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            action,
          ],
        ),
      ),
    );
  }
}
