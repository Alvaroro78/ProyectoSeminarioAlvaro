import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
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
      body: CenteredBody(
        child: IndexedStack(
          index: _index,
          children: [
            EventsPage(
              series: _series,
              userId: _user.id,
              onOpen: (EventSeries s, Edition e) {},
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
