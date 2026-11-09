import 'package:proyecto_seminario_alvaro/models/edition.dart';

int freeSpots(Edition edition) {
  return edition.quota - edition.registrations.length;
}

String nextRegistrationCode(Edition edition) {
  final consecutive = edition.registrations.length + 1;
  return 'R${edition.number}-${consecutive.toString().padLeft(3, '0')}';
}

bool isRegistered(Edition edition, String userId) {
  return edition.registrations.any((r) => r.userId == userId);
}

List<String> missingRequired(Edition edition, Map<String, String> answers) {
  final missing = <String>[];
  for (final field in edition.fields) {
    if (!field.isRequired) continue;
    final answer = answers[field.id] ?? '';
    if (answer.trim().isEmpty) missing.add(field.label);
  }
  return missing;
}
