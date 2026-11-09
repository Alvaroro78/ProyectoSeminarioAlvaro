import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';

/// The screen for creating a new recurring event series.
class NewSeriesScreen extends StatefulWidget {
  const NewSeriesScreen({super.key});

  @override
  State<NewSeriesScreen> createState() => _NewSeriesScreenState();
}

class _NewSeriesScreenState extends State<NewSeriesScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save(List<String> existingNames) {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _error = 'Escribe el nombre de la serie';
      });
      return;
    }

    final exists =
        existingNames.any((n) => n.toLowerCase() == name.toLowerCase());
    if (exists) {
      setState(() {
        _error = 'Ya tienes una serie con ese nombre';
      });
      return;
    }

    final newSeries = EventSeries(
      id: 'series-${DateTime.now().millisecondsSinceEpoch}',
      organizerId: '',
      name: name,
      description: description,
      editions: const [],
    );

    Navigator.pop(context, newSeries);
  }

  @override
  Widget build(BuildContext context) {
    final existingNames =
        (ModalRoute.of(context)?.settings.arguments as List<String>?) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva serie'),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Crea una serie de eventos',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Agrupa las ediciones de un mismo evento recurrente en un solo lugar.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la serie',
                hintText: 'Ej. Charlas de analítica de datos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'De qué trata la serie y con qué frecuencia se realiza.',
                border: OutlineInputBorder(),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => _save(existingNames),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Guardar serie'),
            ),
          ],
        ),
      ),
    );
  }
}
