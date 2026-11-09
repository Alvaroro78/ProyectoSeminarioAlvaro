import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';

/// Replaces every {key} in [text] with the value from [values].
/// Unknown keys are left as-is.
String fillTemplate(String text, Map<String, String> values) {
  var result = text;
  for (final entry in values.entries) {
    result = result.replaceAll('{${entry.key}}', entry.value);
  }
  return result;
}

/// Builds the variable map for F-05 messages of an [edition] belonging to [series].
/// {nombre} is previewed as "invitado".
Map<String, String> messageValues(EventSeries series, Edition edition) {
  return {
    'evento': '${series.name} · Edición ${edition.number}',
    'fecha': formatDate(edition.dateTime),
    'hora': formatTime(edition.dateTime),
    'lugar': edition.place,
    'nombre': 'invitado',
  };
}
