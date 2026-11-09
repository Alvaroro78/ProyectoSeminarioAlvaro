import 'package:proyecto_seminario_alvaro/models/edition.dart';

/// A recurring event series owned by one organizer.
class EventSeries {
  final String id;
  final String organizerId;
  final String name;
  final String description;
  final List<Edition> editions;

  const EventSeries({
    required this.id,
    required this.organizerId,
    required this.name,
    required this.description,
    required this.editions,
  });

  /// Returns a copy with the given fields replaced.
  EventSeries copyWith({
    String? id,
    String? organizerId,
    String? name,
    String? description,
    List<Edition>? editions,
  }) {
    return EventSeries(
      id: id ?? this.id,
      organizerId: organizerId ?? this.organizerId,
      name: name ?? this.name,
      description: description ?? this.description,
      editions: editions ?? this.editions,
    );
  }
}
