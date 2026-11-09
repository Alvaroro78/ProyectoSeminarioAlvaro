import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';

/// Form that builds a task and hands it to whoever uses it.
class TaskForm extends StatefulWidget {
  final Function(EventTask) onAdd;

  const TaskForm({super.key, required this.onAdd});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _ownerController = TextEditingController();
  final _daysController = TextEditingController();
  String? _error;

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() {
        _error = 'Escribe la tarea';
      });
      return;
    }
    final days = int.tryParse(_daysController.text.trim());
    if (days == null || days < -90 || days > 30) {
      setState(() {
        _error = 'Los días deben estar entre −90 y 30';
      });
      return;
    }
    final owner = _ownerController.text.trim();
    widget.onAdd(EventTask(
      id: 't-${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      owner: owner.isEmpty ? 'Sin responsable' : owner,
      offsetDays: days,
      inherited: false,
    ));
    _titleController.clear();
    _ownerController.clear();
    _daysController.clear();
    setState(() {
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text('Agregar tarea', style: textTheme.titleMedium),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tarea',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _ownerController,
              decoration: const InputDecoration(
                labelText: 'Responsable',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _daysController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                labelText: 'Días respecto al evento',
                hintText: '-7',
                helperText: 'Negativo: antes del evento. Positivo: después.',
                border: OutlineInputBorder(),
              ),
            ),
            if (_error != null)
              Text(
                _error!,
                style: textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            FilledButton(
              onPressed: () => _submit(),
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ownerController.dispose();
    _daysController.dispose();
    super.dispose();
  }
}
