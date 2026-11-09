/// A task associated with an edition.
class EventTask {
  final String id;
  final String title;
  final String owner;
  final int offsetDays;
  final DateTime? doneAt;
  final bool inherited;

  const EventTask({
    required this.id,
    required this.title,
    required this.owner,
    required this.offsetDays,
    this.doneAt,
    required this.inherited,
  });

  EventTask copyWith({
    String? id,
    String? title,
    String? owner,
    int? offsetDays,
    DateTime? doneAt,
    bool clearDoneAt = false,
    bool? inherited,
  }) {
    return EventTask(
      id: id ?? this.id,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      offsetDays: offsetDays ?? this.offsetDays,
      doneAt: clearDoneAt ? null : (doneAt ?? this.doneAt),
      inherited: inherited ?? this.inherited,
    );
  }
}
