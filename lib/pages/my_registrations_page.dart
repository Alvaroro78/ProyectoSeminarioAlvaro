import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/registration_card.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';

/// A tab page displaying the attendee's upcoming and past registrations.
class MyRegistrationsPage extends StatelessWidget {
  final List<EventSeries> series;
  final AppUser user;

  const MyRegistrationsPage({
    super.key,
    required this.series,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayDay = DateTime(now.year, now.month, now.day);

    final upcoming = <(EventSeries, Edition, Registration)>[];
    final past = <(EventSeries, Edition, Registration)>[];

    for (final s in series) {
      for (final e in s.editions) {
        for (final r in e.registrations) {
          if (r.userId != user.id) continue;
          final eventDay =
              DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day);
          if (eventDay.isBefore(todayDay)) {
            past.add((s, e, r));
          } else {
            upcoming.add((s, e, r));
          }
        }
      }
    }

    if (upcoming.isEmpty && past.isEmpty) {
      return const EmptyMessage(
        text: 'Todavía no te has inscrito a ningún evento.',
      );
    }

    upcoming.sort((a, b) => a.$2.dateTime.compareTo(b.$2.dateTime));
    past.sort((a, b) => b.$2.dateTime.compareTo(a.$2.dateTime));

    final all = [...upcoming, ...past];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in all)
          RegistrationCard(
            event: '${item.$1.name} · Edición ${item.$2.number}',
            date: formatDate(item.$2.dateTime),
            code: item.$3.code,
            status: _statusLabel(item.$2.dateTime, item.$3.attended, todayDay),
          ),
      ],
    );
  }

  String _statusLabel(DateTime eventDate, bool attended, DateTime todayDay) {
    final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
    if (!eventDay.isBefore(todayDay)) {
      return 'Próximo';
    }
    return attended ? 'Asististe' : 'No asististe';
  }
}
