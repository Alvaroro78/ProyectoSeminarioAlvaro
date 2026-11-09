import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/app_drawer.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';
import 'package:proyecto_seminario_alvaro/pages/events_page.dart';
import 'package:proyecto_seminario_alvaro/pages/my_registrations_page.dart';
import 'package:proyecto_seminario_alvaro/pages/profile_page.dart';

/// The main dashboard for attendees, containing events, registrations and profile tabs.
class AttendeeMainScreen extends StatefulWidget {
  const AttendeeMainScreen({super.key});

  @override
  State<AttendeeMainScreen> createState() => _AttendeeMainScreenState();
}

class _AttendeeMainScreenState extends State<AttendeeMainScreen> {
  late AppUser _user;
  late List<EventSeries> _series;
  bool _initialized = false;
  int _index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _user = ModalRoute.of(context)!.settings.arguments as AppUser;
      _series = buildMockSeries(DateTime.now());
      _initialized = true;
    }
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _selectFromDrawer(int index) {
    Navigator.pop(context);
    setState(() {
      _index = index;
    });
  }

  Future<void> _openEvent(EventSeries series, Edition edition) async {
    final result = await Navigator.pushNamed(
      context,
      '/events/detail',
      arguments: EventArgs(series: series, edition: edition, user: _user),
    );

    if (result is Map<String, String> && mounted) {
      _register(series.id, edition.id, result);
    }
  }

  void _register(
    String seriesId,
    String editionId,
    Map<String, String> answers,
  ) {
    final seriesIndex = _series.indexWhere((s) => s.id == seriesId);
    if (seriesIndex < 0) return;
    final series = _series[seriesIndex];
    final editionIndex = series.editions.indexWhere((e) => e.id == editionId);
    if (editionIndex < 0) return;
    final edition = series.editions[editionIndex];
    if (isRegistered(edition, _user.id) || freeSpots(edition) <= 0) return;

    final registration = Registration(
      id: 'r-${DateTime.now().microsecondsSinceEpoch}',
      userId: _user.id,
      userName: _user.name,
      userEmail: _user.email,
      code: nextRegistrationCode(edition),
      registeredAt: DateTime.now(),
      attended: false,
      answers: answers,
    );

    final editions = [...series.editions];
    editions[editionIndex] = edition.copyWith(
      registrations: [...edition.registrations, registration],
    );
    final updatedSeries = [..._series];
    updatedSeries[seriesIndex] = series.copyWith(editions: editions);

    setState(() {
      _series = updatedSeries;
      _index = 1;
    });
  }

  String get _title {
    switch (_index) {
      case 0:
        return 'Eventos abiertos';
      case 1:
        return 'Mis inscripciones';
      case 2:
      default:
        return 'Mi perfil';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: AppDrawer(
        user: _user,
        sections: const ['Eventos', 'Mis inscripciones', 'Mi perfil'],
        icons: const [
          Icons.event_available,
          Icons.confirmation_number_outlined,
          Icons.person,
        ],
        selected: _index,
        onSelect: _selectFromDrawer,
        onLogout: _logout,
      ),
      body: CenteredBody(
        child: IndexedStack(
          index: _index,
          children: [
            EventsPage(
              userName: _user.name,
              series: _series,
              userId: _user.id,
              onOpen: (s, e) => _openEvent(s, e),
            ),
            MyRegistrationsPage(
              series: _series,
              user: _user,
            ),
            ProfilePage(
              user: _user,
              onLogout: _logout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            label: 'Inscripciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
