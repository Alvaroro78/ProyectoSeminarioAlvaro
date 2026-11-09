import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Card for a registration question: label, type and tags.
class FieldCard extends StatelessWidget {
  final RegistrationField field;
  final int answersCount;
  final bool canEdit;
  final Function() onDelete;

  const FieldCard({
    super.key,
    required this.field,
    required this.answersCount,
    required this.canEdit,
    required this.onDelete,
  });

  String _typeLabel() {
    switch (field.type) {
      case 'number':
        return 'Número';
      case 'yesNo':
        return 'Sí/No';
      default:
        return 'Texto';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tags = [
      _typeLabel(),
      field.isRequired ? 'Obligatoria' : 'Opcional',
      field.inherited ? 'Heredada' : 'Nueva',
      if (answersCount == 1) '1 respuesta',
      if (answersCount > 1) '$answersCount respuestas',
    ].join(' · ');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(field.label, style: textTheme.titleSmall),
                  Text(
                    tags,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                ],
              ),
            ),
            if (canEdit)
              IconButton(
                onPressed: () => onDelete(),
                icon: const Icon(Icons.delete_outline),
              ),
          ],
        ),
      ),
    );
  }
}
