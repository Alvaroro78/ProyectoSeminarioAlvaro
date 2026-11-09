import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/logic/cloning.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

/// The screen for creating a new edition from scratch or by cloning the latest one.
class NewEditionScreen extends StatefulWidget {
  const NewEditionScreen({super.key});

  @override
  State<NewEditionScreen> createState() => _NewEditionScreenState();
}

class _NewEditionScreenState extends State<NewEditionScreen> {
  late EventSeries _series;
  Edition? _base;
  bool _initialized = false;

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _placeController = TextEditingController();
  final _capacityController = TextEditingController();
  final _quotaController = TextEditingController();
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _series = ModalRoute.of(context)!.settings.arguments as EventSeries;
      final sorted = [..._series.editions]
        ..sort((a, b) => a.number.compareTo(b.number));
      _base = sorted.lastOrNull;

      final proposedDate = proposeDate(_series, DateTime.now());
      final y = proposedDate.year.toString();
      final m = proposedDate.month.toString().padLeft(2, '0');
      final d = proposedDate.day.toString().padLeft(2, '0');
      _dateController.text = '$y-$m-$d';

      if (_base != null) {
        _timeController.text = formatTime(_base!.dateTime);
        _placeController.text = _base!.place;
        _capacityController.text = _base!.capacity.toString();
        _quotaController.text = _base!.quota.toString();
      } else {
        _timeController.text = '18:00';
      }

      _initialized = true;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    _capacityController.dispose();
    _quotaController.dispose();
    super.dispose();
  }

  void _save() {
    final parsedDate = parseDate(_dateController.text.trim());
    if (parsedDate == null) {
      setState(() {
        _error = 'La fecha debe ser posterior a hoy';
      });
      return;
    }

    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    if (!parsedDate.isAfter(todayStart)) {
      setState(() {
        _error = 'La fecha debe ser posterior a hoy';
      });
      return;
    }

    final parsedTime = parseTime(_timeController.text.trim());
    final hour = parsedTime?.hour ?? 18;
    final minute = parsedTime?.minute ?? 0;
    final eventDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      hour,
      minute,
    );

    final place = _placeController.text.trim();
    if (place.isEmpty) {
      setState(() {
        _error = 'Escribe el lugar del evento';
      });
      return;
    }

    final capacity = int.tryParse(_capacityController.text.trim()) ?? 0;
    final quota = int.tryParse(_quotaController.text.trim()) ?? 0;
    if (capacity <= 0 || quota <= 0) {
      setState(() {
        _error = 'Capacidad y cupo deben ser números mayores que 0';
      });
      return;
    }

    final newId = 'ed-${DateTime.now().millisecondsSinceEpoch}';
    Edition newEdition;
    if (_base != null) {
      newEdition = cloneEdition(
        _base!,
        newId,
        eventDateTime,
        place,
        capacity,
        quota,
      );
    } else {
      newEdition = firstEdition(
        _series.id,
        newId,
        eventDateTime,
        place,
        capacity,
        quota,
      );
    }

    Navigator.pop(context, newEdition);
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
        title: Text(_base == null
            ? 'Primera edición'
            : 'Edición ${_base!.number + 1}'),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_base != null) ...[
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Copiando de Edición ${_base!.number}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Se copiarán ${_base!.fields.length} preguntas, '
                        '${_base!.messages.length} mensajes y '
                        '${_base!.tasks.length} tareas heredadas.',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ] else ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Esta será la primera edición de la serie. Ingresa los datos iniciales.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Fecha del evento (AAAA-MM-DD)',
                hintText: '2026-12-20',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Hora (HH:MM)',
                hintText: '18:00',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: 'Lugar',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place_outlined),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _capacityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Capacidad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _quotaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cupo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(
                _error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Confirmar y crear edición'),
            ),
          ],
        ),
      ),
    );
  }
}
