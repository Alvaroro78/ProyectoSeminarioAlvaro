import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/greeting_header.dart';
import 'package:proyecto_seminario_alvaro/components/series_card.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

/// A tab page listing an organizer's series.
class SeriesPage extends StatelessWidget {
  final String userName;
  final List<EventSeries> series;
  final Function(EventSeries) onOpen;

  const SeriesPage({
    super.key,
    required this.userName,
    required this.series,
    required this.onOpen,
  });

  String _summary() {
    final published = series
        .expand((s) => s.editions)
        .where((e) => e.status == 'published')
        .length;
    final seriesText = series.length == 1 ? '1 serie' : '${series.length} series';
    final publishedText = published == 1
        ? '1 edición publicada'
        : '$published ediciones publicadas';
    return '$seriesText · $publishedText';
  }

  @override
  Widget build(BuildContext context) {
    final firstName = userName.split(' ').first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GreetingHeader(greeting: 'Hola, $firstName', summary: _summary()),
        if (series.isEmpty)
          const EmptyMessage(
            text: 'Todavía no tienes series. Crea la primera.',
          )
        else
          for (final s in series)
            SeriesCard(
              series: s,
              onTap: () => onOpen(s),
            ),
      ],
    );
  }
}
