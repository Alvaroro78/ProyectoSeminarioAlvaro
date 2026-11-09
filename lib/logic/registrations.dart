import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';

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
  return missingRequiredLabels(edition.fields, answers);
}

List<String> missingRequiredLabels(
  List<RegistrationField> fields,
  Map<String, String> answers,
) {
  final missing = <String>[];
  for (final field in fields) {
    if (!field.isRequired) continue;
    final answer = answers[field.id] ?? '';
    if (answer.trim().isEmpty) missing.add(field.label);
  }
  return missing;
}

String? invalidNumberLabel(
  List<RegistrationField> fields,
  Map<String, String> answers,
) {
  for (final field in fields) {
    if (field.type != 'number') continue;
    final answer = (answers[field.id] ?? '').trim();
    if (answer.isEmpty) continue;
    if (num.tryParse(answer) == null) return field.label;
  }
  return null;
}

int answersCount(Edition edition, String fieldId) {
  return edition.registrations
      .where((r) => (r.answers[fieldId] ?? '').trim().isNotEmpty)
      .length;
}

int attendedCount(Edition edition) {
  return edition.registrations.where((r) => r.attended).length;
}

List<Registration> searchRegistrations(
  List<Registration> registrations,
  String query,
) {
  final text = query.trim().toLowerCase();
  final result = registrations.where((r) {
    if (text.isEmpty) return true;
    return r.userName.toLowerCase().contains(text) ||
        r.code.toLowerCase().contains(text);
  }).toList();
  result.sort((a, b) => a.userName.compareTo(b.userName));
  return result;
}
