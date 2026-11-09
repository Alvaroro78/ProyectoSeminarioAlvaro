import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// A card displaying a published event for attendees with an action on tap.
class EventCard extends StatelessWidget {
  final EventSeries series;
  final Edition edition;
  final String spotsText;
  final Function() onTap;

  const EventCard({
    super.key,
    required this.series,
    required this.edition,
    required this.spotsText,
    required this.onTap,
  });

  Color _spotsColor() {
    if (spotsText.startsWith('Quedan')) return AppColors.published;
    if (spotsText.startsWith('Ya')) return AppColors.primary;
    return AppColors.mutedText;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateParts = formatShortDate(edition.dateTime).split(' ');
    final spotsColor = _spotsColor();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Container(
                width: 56,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      dateParts.first,
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      dateParts.last,
                      style: textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      '${series.name} · Edición ${edition.number}',
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      '${formatTime(edition.dateTime)} · ${edition.place}',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: spotsColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        spotsText,
                        style: textTheme.labelMedium?.copyWith(
                          color: spotsColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
