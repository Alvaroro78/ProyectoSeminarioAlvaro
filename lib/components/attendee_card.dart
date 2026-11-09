import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Card for a registered person with their code and attendance.
class AttendeeCard extends StatelessWidget {
  final Registration registration;
  final bool canEdit;
  final Function() onToggleAttended;

  const AttendeeCard({
    super.key,
    required this.registration,
    required this.canEdit,
    required this.onToggleAttended,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(registration.userName, style: textTheme.titleSmall),
                  Text(
                    registration.userEmail,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                  Text(
                    registration.code,
                    style: textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (registration.attended)
              OutlinedButton.icon(
                onPressed: canEdit ? () => onToggleAttended() : null,
                icon: const Icon(Icons.check, color: AppColors.published),
                label: const Text('Asistió'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.published,
                ),
              )
            else
              FilledButton(
                onPressed: canEdit ? () => onToggleAttended() : null,
                child: const Text('Marcar asistencia'),
              ),
          ],
        ),
      ),
    );
  }
}
