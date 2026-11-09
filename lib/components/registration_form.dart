import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/choice_buttons.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Form with the edition's questions; hands the answers to whoever uses it.
class RegistrationForm extends StatefulWidget {
  final List<RegistrationField> fields;
  final Function(Map<String, String>) onSubmit;

  const RegistrationForm({
    super.key,
    required this.fields,
    required this.onSubmit,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _yesNoAnswers = {};
  String? _error;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      if (field.type != 'yesNo') {
        _controllers[field.id] = TextEditingController();
      }
    }
  }

  Map<String, String> _answers() {
    final answers = <String, String>{};
    for (final field in widget.fields) {
      final value = field.type == 'yesNo'
          ? (_yesNoAnswers[field.id] ?? '')
          : _controllers[field.id]!.text.trim();
      if (value.isNotEmpty) answers[field.id] = value;
    }
    return answers;
  }

  void _submit() {
    final answers = _answers();
    if (missingRequiredLabels(widget.fields, answers).isNotEmpty) {
      setState(() {
        _error = 'Responde las preguntas marcadas con *';
      });
      return;
    }
    final badNumber = invalidNumberLabel(widget.fields, answers);
    if (badNumber != null) {
      setState(() {
        _error = 'La respuesta de «$badNumber» debe ser un número';
      });
      return;
    }
    setState(() {
      _error = null;
    });
    widget.onSubmit(answers);
  }

  Widget _input(RegistrationField field) {
    final label = field.isRequired ? '${field.label} *' : field.label;
    if (field.type == 'yesNo') {
      final current = _yesNoAnswers[field.id];
      final selected = current == 'Sí' ? 0 : (current == 'No' ? 1 : -1);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ChoiceButtons(
            labels: const ['Sí', 'No'],
            selected: selected,
            onSelect: (i) => setState(() {
              _yesNoAnswers[field.id] = i == 0 ? 'Sí' : 'No';
            }),
          ),
        ],
      );
    }
    return TextField(
      controller: _controllers[field.id],
      keyboardType:
          field.type == 'number' ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fields = [...widget.fields]
      ..sort((a, b) => a.order.compareTo(b.order));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        for (final field in fields) _input(field),
        Text(
          'Tu nombre y correo se toman de tu cuenta.',
          style: textTheme.bodySmall?.copyWith(color: AppColors.mutedText),
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
          child: const Text('Confirmar inscripción'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
