import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/choice_buttons.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';

/// Form that builds a message and hands it to whoever uses it.
class MessageForm extends StatefulWidget {
  final Function(EventMessage) onAdd;

  const MessageForm({super.key, required this.onAdd});

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  static const _types = ['invitation', 'reminder', 'thanks', 'other'];

  final _daysController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  int _typeIndex = 0;
  String? _error;

  void _submit() {
    final subject = _subjectController.text.trim();
    final body = _bodyController.text.trim();
    if (subject.isEmpty || body.isEmpty) {
      setState(() {
        _error = 'Escribe el asunto y el cuerpo';
      });
      return;
    }
    final days = int.tryParse(_daysController.text.trim());
    if (days == null || days < -60 || days > 30) {
      setState(() {
        _error = 'Los días deben estar entre −60 y 30';
      });
      return;
    }
    widget.onAdd(EventMessage(
      id: 'm-${DateTime.now().microsecondsSinceEpoch}',
      type: _types[_typeIndex],
      subject: subject,
      body: body,
      offsetDays: days,
      sent: false,
      inherited: false,
    ));
    _daysController.clear();
    _subjectController.clear();
    _bodyController.clear();
    setState(() {
      _error = null;
      _typeIndex = 0;
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
            Text('Agregar mensaje', style: textTheme.titleMedium),
            ChoiceButtons(
              labels: const ['Invitación', 'Recordatorio', 'Agradecimiento', 'Otro'],
              selected: _typeIndex,
              perRow: 2,
              onSelect: (i) => setState(() => _typeIndex = i),
            ),
            TextField(
              controller: _daysController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                labelText: 'Días respecto al evento',
                hintText: '-12',
                helperText: 'Negativo: antes del evento. Positivo: después.',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Asunto',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _bodyController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Cuerpo',
                helperText: 'Variables: {evento} {fecha} {hora} {lugar} {nombre}',
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
    _daysController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
