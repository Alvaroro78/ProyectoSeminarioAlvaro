import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';

String taskDueText(EventTask task, DateTime eventDate) {
  final due = dueDate(eventDate, task.offsetDays);
  return '${formatOffset(task.offsetDays)} · ${formatShortDate(due)}';
}

int overdueDays(EventTask task, DateTime eventDate, DateTime today) {
  if (task.doneAt != null) return 0;
  final days = daysBetween(dueDate(eventDate, task.offsetDays), today);
  return days > 0 ? days : 0;
}

String taskStatusText(EventTask task, DateTime eventDate, DateTime today) {
  if (task.doneAt != null) return 'Hecha · ${formatShortDate(task.doneAt!)}';
  final delay = overdueDays(task, eventDate, today);
  if (delay == 1) return 'Atrasada 1 día';
  if (delay > 1) return 'Atrasada $delay días';
  return 'Pendiente';
}

String tasksSummary(Edition edition, DateTime today) {
  final total = edition.tasks.length;
  final done = edition.tasks.where((t) => t.doneAt != null).length;
  final overdue = edition.tasks
      .where((t) => overdueDays(t, edition.dateTime, today) > 0)
      .length;
  final base = '$done de $total hechas';
  if (overdue == 0) return base;
  if (overdue == 1) return '$base · 1 atrasada';
  return '$base · $overdue atrasadas';
}

List<EventTask> sortedTasks(List<EventTask> tasks) {
  return [...tasks]..sort((a, b) => a.offsetDays.compareTo(b.offsetDays));
}
