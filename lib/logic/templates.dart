import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

String fillTemplate(String text, Map<String, String> values) {
  var result = text;
  for (final entry in values.entries) {
    result = result.replaceAll('{${entry.key}}', entry.value);
  }
  return result;
}

Map<String, String> messageValues(EventSeries series, Edition edition) {
  return {
    'evento': '${series.name} · Edición ${edition.number}',
    'fecha': formatDate(edition.dateTime),
    'hora': formatTime(edition.dateTime),
    'lugar': edition.place,
    'nombre': 'invitado',
  };
}
