import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Card for a message: type, send date, subject, preview and status.
class MessageCard extends StatelessWidget {
  final EventMessage message;
  final String typeLabel;
  final String sendDateText;
  final String statusText;
  final String subject;
  final String preview;
  final bool canEdit;
  final Function() onToggleSent;
  final Function() onDelete;

  const MessageCard({
    super.key,
    required this.message,
    required this.typeLabel,
    required this.sendDateText,
    required this.statusText,
    required this.subject,
    required this.preview,
    required this.canEdit,
    required this.onToggleSent,
    required this.onDelete,
  });

  Color _statusColor() {
    if (message.sent) return AppColors.published;
    if (statusText.startsWith('Pendiente')) return AppColors.late;
    return AppColors.mutedText;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$typeLabel · $sendDateText',
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Text(
                  statusText,
                  style: textTheme.labelMedium?.copyWith(
                    color: _statusColor(),
                  ),
                ),
              ],
            ),
            Text(subject, style: textTheme.titleSmall),
            Text(preview, style: textTheme.bodyMedium),
            if (canEdit)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  TextButton.icon(
                    onPressed: () => onDelete(),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Quitar'),
                  ),
                  if (message.sent)
                    OutlinedButton(
                      onPressed: () => onToggleSent(),
                      child: const Text('Marcar sin enviar'),
                    )
                  else
                    FilledButton(
                      onPressed: () => onToggleSent(),
                      child: const Text('Marcar enviado'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
