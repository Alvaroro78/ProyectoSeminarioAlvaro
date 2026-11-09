import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                series.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              if (series.description.isNotEmpty) ...[
                Text(
                  series.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    countText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    nextText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
