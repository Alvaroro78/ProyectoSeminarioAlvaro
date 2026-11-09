import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Card for a task: title, owner, due date and status.
class TaskCard extends StatelessWidget {
  final EventTask task;
  final String dueText;
  final String statusText;
  final bool isOverdue;
  final bool canEdit;
  final Function() onToggleDone;
  final Function() onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.dueText,
    required this.statusText,
    required this.isOverdue,
    required this.canEdit,
    required this.onToggleDone,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final done = task.doneAt != null;
    final statusColor = isOverdue
        ? AppColors.late
        : (done ? AppColors.published : AppColors.mutedText);
    final newTag = task.inherited ? '' : ' · Nueva';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            IconButton(
              onPressed: canEdit ? () => onToggleDone() : null,
              icon: Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? AppColors.published : AppColors.mutedText,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(
                    task.title,
                    style: textTheme.titleSmall?.copyWith(
                      decoration: done ? TextDecoration.lineThrough : null,
                      color: done ? AppColors.mutedText : null,
                    ),
                  ),
                  Text(
                    '${task.owner} · $dueText$newTag',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                  Text(
                    statusText,
                    style: textTheme.labelMedium?.copyWith(color: statusColor),
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
