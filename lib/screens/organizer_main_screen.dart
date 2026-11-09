import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/pages/profile_page.dart';
import 'package:proyecto_seminario_alvaro/pages/series_page.dart';

/// The main dashboard for organizers, containing series and profile tabs.
class OrganizerMainScreen extends StatefulWidget {
  const OrganizerMainScreen({super.key});

  @override
  State<OrganizerMainScreen> createState() => _OrganizerMainScreenState();
}

class _OrganizerMainScreenState extends State<OrganizerMainScreen> {
  late AppUser _user;
  late List<EventSeries> _series;
  bool _initialized = false;
  int _index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _user = ModalRoute.of(context)!.settings.arguments as AppUser;
      _series = buildMockSeries(DateTime.now())
          .where((s) => s.organizerId == _user.id)
          .toList();
      _initialized = true;
    }
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<void> _newSeries() async {
    final names = _series.map((s) => s.name).toList();
    final created = await Navigator.pushNamed(
      context,
      '/series/new',
      arguments: names,
    );

    if (created is EventSeries && mounted) {
      setState(() {
        _series.add(created.copyWith(organizerId: _user.id));
      });
    }
  }

  Future<void> _openSeries(EventSeries series) async {
    final updated = await Navigator.pushNamed(
      context,
      '/series',
      arguments: series,
    );

    if (updated is EventSeries && mounted) {
      setState(() {
        final index = _series.indexWhere((s) => s.id == updated.id);
        if (index >= 0) {
          _series[index] = updated;
        }
      });
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
        title: Text(_index == 0 ? 'Mis series' : 'Mi perfil'),
      ),
      body: CenteredBody(
        child: IndexedStack(
          index: _index,
          children: [
            SeriesPage(
              series: _series,
              onOpen: _openSeries,
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
            icon: Icon(Icons.list_alt),
            label: 'Series',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              onPressed: _newSeries,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
