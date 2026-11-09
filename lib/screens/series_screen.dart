import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/edition_card.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/logic/savings.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';

/// The screen displaying a series and its editions from newest to oldest.
class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  late EventSeries _series;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _series = ModalRoute.of(context)!.settings.arguments as EventSeries;
      _initialized = true;
    }
  }

  Future<void> _newEdition() async {
    final created = await Navigator.pushNamed(
      context,
      '/editions/new',
      arguments: _series,
    );

    if (created is Edition && mounted) {
      setState(() {
        _series = _series.copyWith(
          editions: [..._series.editions, created],
        );
      });
    }
  }

  Future<void> _openEdition(Edition edition) async {
    final updated = await Navigator.pushNamed(
      context,
      '/editions',
      arguments: EditionArgs(series: _series, edition: edition),
    );

    if (updated is Edition && mounted) {
      setState(() {
        final index = _series.editions.indexWhere((e) => e.id == updated.id);
        if (index >= 0) {
          final list = [..._series.editions];
          list[index] = updated;
          _series = _series.copyWith(editions: list);
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

    final sortedEditions = [..._series.editions]
      ..sort((a, b) => b.number.compareTo(a.number));

    return Scaffold(
      appBar: AppBar(
        title: Text(_series.name),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _series),
        ),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_series.description.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _series.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ediciones',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                FilledButton.icon(
                  onPressed: _newEdition,
                  icon: const Icon(Icons.add),
                  label: const Text('Nueva edición'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (sortedEditions.isEmpty)
              const EmptyMessage(
                text: 'Esta serie no tiene ediciones. Crea la primera.',
              )
            else
              for (final ed in sortedEditions)
                EditionCard(
                  edition: ed,
                  reusedPercent: reusedPercent(ed),
                  onTap: () => _openEdition(ed),
                ),
          ],
        ),
      ),
    );
  }
}
