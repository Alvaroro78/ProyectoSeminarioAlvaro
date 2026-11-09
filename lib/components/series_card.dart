import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// A card displaying a series summary with an action on tap.
class SeriesCard extends StatelessWidget {
  final EventSeries series;
  final Function() onTap;

  const SeriesCard({
    super.key,
    required this.series,
    required this.onTap,
  });

  String _nextEditionText(DateTime today) {
    final todayStart = DateTime(today.year, today.month, today.day);
    final upcoming = series.editions.where((e) {
      if (e.status != 'draft' && e.status != 'published') return false;
      final eDay = DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day);
      return !eDay.isBefore(todayStart);
    }).toList();

    if (upcoming.isEmpty) return 'Sin próximas ediciones';
    upcoming.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return 'Próxima: ${formatDate(upcoming.first.dateTime)}';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final count = series.editions.length;
    final countText = count == 1 ? '1 edición' : '$count ediciones';
    final nextText = _nextEditionText(DateTime.now());

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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.event_repeat, color: AppColors.primary),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(series.name, style: textTheme.titleMedium),
                    if (series.description.isNotEmpty)
                      Text(
                        series.description,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.mutedText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(countText, style: textTheme.labelMedium),
                        Text(
                          nextText,
                          style: textTheme.labelMedium?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
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
