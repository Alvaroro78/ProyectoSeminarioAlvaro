import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

/// Navigation arguments for an edition screen.
class EditionArgs {
  final EventSeries series;
  final Edition edition;

  const EditionArgs({required this.series, required this.edition});
}

/// Navigation arguments for the event detail screen.
class EventArgs {
  final EventSeries series;
  final Edition edition;
  final AppUser user;

  const EventArgs({
    required this.series,
    required this.edition,
    required this.user,
  });
}
