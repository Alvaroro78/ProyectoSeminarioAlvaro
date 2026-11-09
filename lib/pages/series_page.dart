import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/series_card.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

/// A tab page listing an organizer's series.
class SeriesPage extends StatelessWidget {
  final List<EventSeries> series;
  final Function(EventSeries) onOpen;

  const SeriesPage({
    super.key,
    required this.series,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty) {
      return const EmptyMessage(
        text: 'Todavía no tienes series. Crea la primera.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final s in series)
          SeriesCard(
            series: s,
            onTap: () => onOpen(s),
          ),
      ],
    );
  }
}
