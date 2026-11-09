import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/screens/attendee_main_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/edition_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/login_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/new_edition_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/new_series_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/organizer_main_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/register_screen.dart';
import 'package:proyecto_seminario_alvaro/screens/series_screen.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

void main() {
  runApp(const App());
}

/// The root application widget with routes and theme configuration.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProyectoSeminarioAlvaro',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/organizer': (context) => const OrganizerMainScreen(),
        '/series/new': (context) => const NewSeriesScreen(),
        '/series': (context) => const SeriesScreen(),
        '/editions/new': (context) => const NewEditionScreen(),
        '/editions': (context) => const EditionScreen(),
        '/attendee': (context) => const AttendeeMainScreen(),
      },
    );
  }
}
