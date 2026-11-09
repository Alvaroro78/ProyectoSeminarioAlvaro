import 'package:proyecto_seminario_alvaro/models/edition.dart';

/// Returns the number of free spots in an edition.
int freeSpots(Edition edition) {
  return edition.quota - edition.registrations.length;
}

/// Returns the next registration code for an edition.
/// Format: "R{number}-{consecutive with 3 digits}".
String nextRegistrationCode(Edition edition) {
  final consecutive = edition.registrations.length + 1;
  return 'R${edition.number}-${consecutive.toString().padLeft(3, '0')}';
}

/// Returns true if the user with [userId] is already registered in [edition].
bool isRegistered(Edition edition, String userId) {
  return edition.registrations.any((r) => r.userId == userId);
}

/// Returns the labels of required fields that are missing in [answers].
/// [answers] maps field id → response string.
List<String> missingRequired(Edition edition, Map<String, String> answers) {
  final missing = <String>[];
  for (final field in edition.fields) {
    if (!field.isRequired) continue;
    final answer = answers[field.id] ?? '';
    if (answer.trim().isEmpty) missing.add(field.label);
  }
  return missing;
}
