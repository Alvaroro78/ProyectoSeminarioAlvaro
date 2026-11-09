import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/decision.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/models/recommendation.dart';

List<Edition> historyFor(EventSeries series, Edition edition) {
  final closed = series.editions
      .where((e) => e.status == 'closed' && e.number < edition.number)
      .toList()
    ..sort((a, b) => a.number.compareTo(b.number));
  if (closed.length <= 3) return closed;
  return closed.sublist(closed.length - 3);
}

double attendanceRate(List<Edition> history) {
  final totalRegistered =
      history.fold<int>(0, (s, e) => s + e.registrations.length);
  if (totalRegistered == 0) return 0;
  final totalAttended = history.fold<int>(
    0,
    (s, e) => s + e.registrations.where((r) => r.attended).length,
  );
  return totalAttended / totalRegistered;
}

List<Recommendation> buildRecommendations(
  EventSeries series,
  Edition edition,
) {
  final history = historyFor(series, edition);
  if (history.length < 2) return [];

  final decided = {
    for (final d in edition.decisions) '${d.rule}|${d.reference}': d
  };

  bool wasDecided(String rule, String reference) =>
      decided.containsKey('$rule|$reference');

  final recs = <Recommendation>[];
  final rate = attendanceRate(history);
  final totalHistoryRegistered =
      history.fold<int>(0, (s, e) => s + e.registrations.length);
  final totalHistoryAttended = history.fold<int>(
    0,
    (s, e) => s + e.registrations.where((r) => r.attended).length,
  );
  final ratePercent = (rate * 100).round();

  if (!wasDecided('R1', '')) {
    if (rate < 0.9) {
      final suggested = (edition.capacity / rate).floor();
      if (edition.quota < suggested) {
        recs.add(Recommendation(
          rule: 'R1',
          reference: '',
          title: 'Abrir más cupos',
          evidence:
              'En las últimas ${history.length} ediciones asistieron '
              '$totalHistoryAttended de $totalHistoryRegistered inscritos '
              '($ratePercent %). Para llenar ${edition.capacity} lugares, '
              'abre $suggested cupos.',
          actionLabel: 'Aceptar',
          value: suggested,
        ));
      }
    }
  }

  for (final task in edition.tasks) {
    if (task.doneAt != null) continue;
    if (wasDecided('R2', task.title)) continue;

    final allDelays = <int>[];
    int lateCount = 0;
    for (final he in history) {
      final ht = he.tasks
          .where((t) => t.title == task.title && t.doneAt != null)
          .firstOrNull;
      if (ht == null) continue;
      final due = dueDate(he.dateTime, ht.offsetDays);
      final delay = daysBetween(due, ht.doneAt!);
      allDelays.add(delay);
      if (delay > 0) lateCount++;
    }

    if (lateCount < 2) continue;

    final avgDelay = allDelays.fold<int>(0, (s, d) => s + d) / allDelays.length;
    final suggested = task.offsetDays - avgDelay.ceil();
    if (suggested >= task.offsetDays) continue;

    recs.add(Recommendation(
      rule: 'R2',
      reference: task.title,
      title: 'Adelantar "${task.title}"',
      evidence:
          'Se completó tarde en $lateCount de ${allDelays.length} ediciones, '
          'en promedio ${avgDelay.ceil()} días.',
      actionLabel: 'Aceptar',
      value: suggested,
    ));
  }

  for (final field in edition.fields) {
    if (field.isRequired) continue;
    if (wasDecided('R3', field.label)) continue;

    final answeredInCurrent = edition.registrations
        .any((r) => (r.answers[field.id] ?? '').trim().isNotEmpty);
    if (answeredInCurrent) continue;

    final histEditionsWithField = <Edition>[];
    for (final he in history) {
      if (he.fields.any((f) => f.label == field.label)) {
        histEditionsWithField.add(he);
      }
    }
    if (histEditionsWithField.isEmpty) continue;

    final totalInscritos = histEditionsWithField.fold<int>(
      0,
      (s, e) => s + e.registrations.length,
    );
    if (totalInscritos == 0) continue;

    int totalResponded = 0;
    for (final he in histEditionsWithField) {
      final hField = he.fields.firstWhere((f) => f.label == field.label);
      for (final reg in he.registrations) {
        final ans = reg.answers[hField.id] ?? '';
        if (ans.trim().isNotEmpty) totalResponded++;
      }
    }

    final tasa = totalResponded / totalInscritos;
    if (tasa >= 0.20) continue;

    final percent = (tasa * 100).round();
    recs.add(Recommendation(
      rule: 'R3',
      reference: field.label,
      title: 'Quitar "${field.label}"',
      evidence:
          'Solo $totalResponded de $totalInscritos inscritos la respondieron ($percent %).',
      actionLabel: 'Aceptar',
    ));
  }

  if (!wasDecided('R4', '')) {
    final frequentPeople = _frequentAttendees(history, edition);
    if (frequentPeople.isNotEmpty) {
      recs.add(Recommendation(
        rule: 'R4',
        reference: '',
        title: 'Invita a ${frequentPeople.length} asistentes frecuentes',
        evidence:
            'Asistieron a 2 o más de las últimas ${history.length} ediciones '
            'y no se han inscrito.',
        actionLabel: 'Aceptar',
        people: frequentPeople,
      ));
    }
  }

  if (!wasDecided('R5', '')) {
    final inscribed = edition.registrations.length;
    if (inscribed > 0) {
      final expected = (inscribed * rate).ceil();
      recs.add(Recommendation(
        rule: 'R5',
        reference: '',
        title: 'Asistencia esperada',
        evidence:
            'Con $inscribed inscritos y una asistencia histórica del '
            '$ratePercent %, espera $expected asistentes.',
        actionLabel: 'Aceptar',
        value: expected,
      ));
    }
  }

  return recs;
}

List<String> _frequentAttendees(List<Edition> history, Edition edition) {
  final registeredUserIds =
      edition.registrations.map((r) => r.userId).toSet();

  final attendanceCount = <String, int>{};
  final userInfo = <String, (String, String)>{};
  for (final he in history) {
    for (final reg in he.registrations) {
      if (reg.attended) {
        attendanceCount[reg.userId] = (attendanceCount[reg.userId] ?? 0) + 1;
        userInfo[reg.userId] = (reg.userName, reg.userEmail);
      }
    }
  }

  final frequent = <String>[];
  for (final entry in attendanceCount.entries) {
    if (entry.value >= 2 && !registeredUserIds.contains(entry.key)) {
      final info = userInfo[entry.key]!;
      frequent.add('${info.$1} · ${info.$2}');
    }
  }

  frequent.sort((a, b) => a.compareTo(b));
  return frequent;
}

Edition acceptRecommendation(
  Edition edition,
  Recommendation rec,
  DateTime today,
) {
  final decision = Decision(
    rule: rec.rule,
    reference: rec.reference,
    accepted: true,
    decidedAt: today,
  );

  Edition updated;
  switch (rec.rule) {
    case 'R1':
      updated = edition.copyWith(
        quota: rec.value!,
        decisions: [...edition.decisions, decision],
      );
    case 'R2':
      final tasks = edition.tasks.map((t) {
        if (t.title == rec.reference) {
          return t.copyWith(offsetDays: rec.value!);
        }
        return t;
      }).toList();
      updated = edition.copyWith(
        tasks: tasks,
        decisions: [...edition.decisions, decision],
      );
    case 'R3':
      final fields =
          edition.fields.where((f) => f.label != rec.reference).toList();
      final reordered = [
        for (var i = 0; i < fields.length; i++)
          fields[i].copyWith(order: i + 1),
      ];
      updated = edition.copyWith(
        fields: reordered,
        decisions: [...edition.decisions, decision],
      );
    case 'R4':
      updated = edition.copyWith(
        decisions: [...edition.decisions, decision],
      );
    case 'R5':
      final taskId = 't-r5-${edition.id}-${today.millisecondsSinceEpoch}';
      final newTask = EventTask(
        id: taskId,
        title: 'Ajustar la logística para ${rec.value} asistentes',
        owner: 'Logística',
        offsetDays: -2,
        doneAt: null,
        inherited: false,
      );
      updated = edition.copyWith(
        tasks: [...edition.tasks, newTask],
        decisions: [...edition.decisions, decision],
      );
    default:
      updated = edition.copyWith(
        decisions: [...edition.decisions, decision],
      );
  }
  return updated;
}

Edition discardRecommendation(
  Edition edition,
  Recommendation rec,
  DateTime today,
) {
  final decision = Decision(
    rule: rec.rule,
    reference: rec.reference,
    accepted: false,
    decidedAt: today,
  );
  return edition.copyWith(
    decisions: [...edition.decisions, decision],
  );
}
