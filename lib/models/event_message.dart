/// A message template associated with an edition.
class EventMessage {
  final String id;
  final String type; // 'invitation', 'reminder', 'thanks', 'other'
  final String subject;
  final String body;
  final int offsetDays;
  final bool sent;
  final bool inherited;

  const EventMessage({
    required this.id,
    required this.type,
    required this.subject,
    required this.body,
    required this.offsetDays,
    required this.sent,
    required this.inherited,
  });

  /// Returns a copy with the given fields replaced.
  EventMessage copyWith({
    String? id,
    String? type,
    String? subject,
    String? body,
    int? offsetDays,
    bool? sent,
    bool? inherited,
  }) {
    return EventMessage(
      id: id ?? this.id,
      type: type ?? this.type,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      offsetDays: offsetDays ?? this.offsetDays,
      sent: sent ?? this.sent,
      inherited: inherited ?? this.inherited,
    );
  }
}
