import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/task_card.dart';
import 'package:proyecto_seminario_alvaro/components/task_form.dart';
import 'package:proyecto_seminario_alvaro/logic/tasks.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Screen with the checklist of an edition and its relative due dates.
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late Edition _edition;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments as EditionArgs;
      _edition = args.edition;
      _initialized = true;
    }
  }

  bool get _canEdit => _edition.status != 'closed';

  void _toggleDone(EventTask task) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    setState(() {
      _edition = _edition.copyWith(
        tasks: [
          for (final t in _edition.tasks)
            if (t.id != task.id)
              t
            else if (t.doneAt != null)
              t.copyWith(clearDoneAt: true)
            else
              t.copyWith(doneAt: today),
        ],
      );
    });
  }

  void _deleteTask(EventTask task) {
    setState(() {
      _edition = _edition.copyWith(
        tasks: _edition.tasks.where((t) => t.id != task.id).toList(),
      );
    });
  }

  void _addTask(EventTask task) {
    setState(() {
      _edition = _edition.copyWith(tasks: [..._edition.tasks, task]);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    final today = DateTime.now();
    final tasks = sortedTasks(_edition.tasks);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas · Edición ${_edition.number}'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _edition),
        ),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              tasksSummary(_edition, today),
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            if (!_canEdit) ...[
              Text(
                'Edición cerrada: solo lectura.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (tasks.isEmpty)
              const EmptyMessage(text: 'Esta edición no tiene tareas.')
            else
              for (final task in tasks)
                TaskCard(
                  task: task,
                  dueText: taskDueText(task, _edition.dateTime),
                  statusText: taskStatusText(task, _edition.dateTime, today),
                  isOverdue: overdueDays(task, _edition.dateTime, today) > 0,
                  canEdit: _canEdit,
                  onToggleDone: () => _toggleDone(task),
                  onDelete: () => _deleteTask(task),
                ),
            if (_canEdit) ...[
              const SizedBox(height: 16),
              TaskForm(onAdd: (task) => _addTask(task)),
            ],
          ],
        ),
      ),
    );
  }
}
