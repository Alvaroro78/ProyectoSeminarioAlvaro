import 'package:proyecto_seminario_alvaro/models/registration_field.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';
import 'package:proyecto_seminario_alvaro/models/decision.dart';

/// One occurrence of a recurring event series.
class Edition {
  final String id;
  final String seriesId;
  final String? sourceEditionId;
  final int number;
  final DateTime dateTime;
  final String place;
  final int capacity;
  final int quota;
  final String status; // 'draft', 'published', 'closed'
  final List<RegistrationField> fields;
  final List<EventMessage> messages;
  final List<EventTask> tasks;
  final List<Registration> registrations;
  final List<Decision> decisions;

  const Edition({
    required this.id,
    required this.seriesId,
    this.sourceEditionId,
    required this.number,
    required this.dateTime,
    required this.place,
    required this.capacity,
    required this.quota,
    required this.status,
    required this.fields,
    required this.messages,
    required this.tasks,
    required this.registrations,
    required this.decisions,
  });

  /// Returns a copy with the given fields replaced.
  Edition copyWith({
    String? id,
    String? seriesId,
    String? sourceEditionId,
    bool clearSourceEditionId = false,
    int? number,
    DateTime? dateTime,
    String? place,
    int? capacity,
    int? quota,
    String? status,
    List<RegistrationField>? fields,
    List<EventMessage>? messages,
    List<EventTask>? tasks,
    List<Registration>? registrations,
    List<Decision>? decisions,
  }) {
    return Edition(
      id: id ?? this.id,
      seriesId: seriesId ?? this.seriesId,
      sourceEditionId: clearSourceEditionId
          ? null
          : (sourceEditionId ?? this.sourceEditionId),
      number: number ?? this.number,
      dateTime: dateTime ?? this.dateTime,
      place: place ?? this.place,
      capacity: capacity ?? this.capacity,
      quota: quota ?? this.quota,
      status: status ?? this.status,
      fields: fields ?? this.fields,
      messages: messages ?? this.messages,
      tasks: tasks ?? this.tasks,
      registrations: registrations ?? this.registrations,
      decisions: decisions ?? this.decisions,
    );
  }
}
