import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/event_card.dart';
import 'package:proyecto_seminario_alvaro/components/greeting_header.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

/// A tab page listing published events open for registration.
class EventsPage extends StatelessWidget {
  final String userName;
  final List<EventSeries> series;
  final String userId;
  final Function(EventSeries, Edition) onOpen;

  const EventsPage({
    super.key,
    required this.userName,
    required this.series,
    required this.userId,
    required this.onOpen,
  });

  String _spotsText(Edition edition) {
    if (isRegistered(edition, userId)) return 'Ya estás inscrito';
    final spots = freeSpots(edition);
    if (spots <= 0) return 'Sin cupos';
    return 'Quedan $spots cupos';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayDay = DateTime(now.year, now.month, now.day);

    final items = <(EventSeries, Edition)>[];
    for (final s in series) {
      for (final e in s.editions) {
        if (e.status != 'published') continue;
        final eventDay = DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day);
        if (!eventDay.isAfter(todayDay)) continue;
        items.add((s, e));
      }
    }

    items.sort((a, b) => a.$2.dateTime.compareTo(b.$2.dateTime));

    final firstName = userName.split(' ').first;
    final summary = items.length == 1
        ? '1 evento abierto para inscribirte'
        : '${items.length} eventos abiertos para inscribirte';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GreetingHeader(greeting: 'Hola, $firstName', summary: summary),
        if (items.isEmpty)
          const EmptyMessage(text: 'No hay eventos abiertos por ahora.')
        else
          for (final item in items)
            EventCard(
              series: item.$1,
              edition: item.$2,
              spotsText: _spotsText(item.$2),
              onTap: () => onOpen(item.$1, item.$2),
            ),
      ],
    );
  }
}
