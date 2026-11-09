import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';

String messageTypeLabel(String type) {
  switch (type) {
    case 'invitation':
      return 'Invitación';
    case 'reminder':
      return 'Recordatorio';
    case 'thanks':
      return 'Agradecimiento';
    default:
      return 'Otro';
  }
}

String messageSendText(EventMessage message, DateTime eventDate) {
  final send = dueDate(eventDate, message.offsetDays);
  return '${formatOffset(message.offsetDays)} · ${formatShortDate(send)}';
}

String messageStatusText(
  EventMessage message,
  DateTime eventDate,
  DateTime today,
) {
  if (message.sent) return 'Enviado';
  final send = dueDate(eventDate, message.offsetDays);
  if (daysBetween(send, today) > 0) {
    return 'Pendiente desde el ${formatShortDate(send)}';
  }
  return 'Por enviar';
}

int sentCount(Edition edition) {
  return edition.messages.where((m) => m.sent).length;
}

List<EventMessage> sortedMessages(List<EventMessage> messages) {
  return [...messages]..sort((a, b) => a.offsetDays.compareTo(b.offsetDays));
}
