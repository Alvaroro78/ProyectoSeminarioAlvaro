import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Box with the invitation text and the emails to send it to.
class InvitationBox extends StatelessWidget {
  final String text;
  final List<String> emails;
  final Function() onClose;

  const InvitationBox({
    super.key,
    required this.text,
    required this.emails,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.recommendationBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.recommendationBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Invitación para frecuentes',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.recommendationTitle,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onClose(),
                icon: const Icon(Icons.close, size: 20),
              ),
            ],
          ),
          SelectableText(text, style: textTheme.bodyMedium),
          if (emails.isNotEmpty) ...[
            Text('Destinatarios:', style: textTheme.titleSmall),
            SelectableText(
              emails.join(', '),
              style: textTheme.bodySmall?.copyWith(color: AppColors.mutedText),
            ),
          ],
        ],
      ),
    );
  }
}
