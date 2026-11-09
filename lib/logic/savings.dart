import 'package:proyecto_seminario_alvaro/models/edition.dart';

int reusedPercent(Edition edition) {
  final total =
      edition.fields.length + edition.messages.length + edition.tasks.length;
  if (total == 0) return 0;
  final inherited = edition.fields.where((f) => f.inherited).length +
      edition.messages.where((m) => m.inherited).length +
      edition.tasks.where((t) => t.inherited).length;
  return (inherited / total * 100).round();
}
