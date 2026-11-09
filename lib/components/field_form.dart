import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/choice_buttons.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';

/// Form that builds a registration question and hands it to whoever uses it.
class FieldForm extends StatefulWidget {
  final List<String> existingLabels;
  final Function(RegistrationField) onAdd;

  const FieldForm({
    super.key,
    required this.existingLabels,
    required this.onAdd,
  });

  @override
  State<FieldForm> createState() => _FieldFormState();
}

class _FieldFormState extends State<FieldForm> {
  static const _types = ['text', 'number', 'yesNo'];

  final _labelController = TextEditingController();
  int _typeIndex = 0;
  bool _isRequired = false;
  String? _error;

  void _submit() {
    final label = _labelController.text.trim();
    if (label.isEmpty) {
      setState(() {
        _error = 'Escribe la pregunta';
      });
      return;
    }
    final exists = widget.existingLabels
        .any((l) => l.toLowerCase() == label.toLowerCase());
    if (exists) {
      setState(() {
        _error = 'Esa pregunta ya existe';
      });
      return;
    }
    widget.onAdd(RegistrationField(
      id: 'f-${DateTime.now().microsecondsSinceEpoch}',
      label: label,
      type: _types[_typeIndex],
      isRequired: _isRequired,
      order: 0,
      inherited: false,
    ));
    _labelController.clear();
    setState(() {
      _error = null;
      _typeIndex = 0;
      _isRequired = false;
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
            Text('Agregar pregunta', style: textTheme.titleMedium),
            TextField(
              controller: _labelController,
              decoration: const InputDecoration(
                labelText: 'Pregunta',
                border: OutlineInputBorder(),
              ),
            ),
            ChoiceButtons(
              labels: const ['Texto', 'Número', 'Sí/No'],
              selected: _typeIndex,
              onSelect: (i) => setState(() => _typeIndex = i),
            ),
            ChoiceButtons(
              labels: const ['Opcional', 'Obligatoria'],
              selected: _isRequired ? 1 : 0,
              onSelect: (i) => setState(() => _isRequired = i == 1),
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
    _labelController.dispose();
    super.dispose();
  }
}
