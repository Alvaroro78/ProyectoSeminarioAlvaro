import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';

DateTime proposeDate(EventSeries series, DateTime today) {
  final sorted = [...series.editions]
    ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  DateTime candidate;
  if (sorted.length >= 2) {
    final gap =
        daysBetween(sorted[sorted.length - 2].dateTime, sorted.last.dateTime);
    candidate = DateTime(
      sorted.last.dateTime.year,
      sorted.last.dateTime.month,
      sorted.last.dateTime.day + gap,
      sorted.last.dateTime.hour,
      sorted.last.dateTime.minute,
    );
  } else if (sorted.length == 1) {
    candidate = DateTime(
      sorted.first.dateTime.year,
      sorted.first.dateTime.month,
      sorted.first.dateTime.day + 30,
      sorted.first.dateTime.hour,
      sorted.first.dateTime.minute,
    );
  } else {
    candidate = DateTime(
      today.year,
      today.month,
      today.day + 7,
    );
  }

  final todayOnly = DateTime(today.year, today.month, today.day);
  final candidateOnly =
      DateTime(candidate.year, candidate.month, candidate.day);
  if (!candidateOnly.isAfter(todayOnly)) {
    return DateTime(today.year, today.month, today.day + 7);
  }
  return candidate;
}

Edition cloneEdition(
  Edition base,
  String newId,
  DateTime dateTime,
  String place,
  int capacity,
  int quota,
) {
  final fields = base.fields
      .map((f) => RegistrationField(
            id: 'f-$newId-${f.id}',
            label: f.label,
            type: f.type,
            isRequired: f.isRequired,
            order: f.order,
            inherited: true,
          ))
      .toList();

  final messages = base.messages
      .map((m) => EventMessage(
            id: 'm-$newId-${m.id}',
            type: m.type,
            subject: m.subject,
            body: m.body,
            offsetDays: m.offsetDays,
            sent: false,
            inherited: true,
          ))
      .toList();

  final tasks = base.tasks
      .map((t) => EventTask(
            id: 't-$newId-${t.id}',
            title: t.title,
            owner: t.owner,
            offsetDays: t.offsetDays,
            doneAt: null,
            inherited: true,
          ))
      .toList();

  return Edition(
    id: newId,
    seriesId: base.seriesId,
    sourceEditionId: base.id,
    number: base.number + 1,
    dateTime: dateTime,
    place: place,
    capacity: capacity,
    quota: quota,
    status: 'draft',
    fields: fields,
    messages: messages,
    tasks: tasks,
    registrations: [],
    decisions: [],
  );
}

Edition firstEdition(
  String seriesId,
  String newId,
  DateTime dateTime,
  String place,
  int capacity,
  int quota,
) {
  return Edition(
    id: newId,
    seriesId: seriesId,
    sourceEditionId: null,
    number: 1,
    dateTime: dateTime,
    place: place,
    capacity: capacity,
    quota: quota,
    status: 'draft',
    fields: [],
    messages: [],
    tasks: [],
    registrations: [],
    decisions: [],
  );
}

bool canPublish(Edition edition, DateTime today) {
  final todayOnly = DateTime(today.year, today.month, today.day);
  final editionDate = DateTime(
    edition.dateTime.year,
    edition.dateTime.month,
    edition.dateTime.day,
  );
  return editionDate.isAfter(todayOnly);
}
