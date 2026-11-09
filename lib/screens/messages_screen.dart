import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/components/empty_message.dart';
import 'package:proyecto_seminario_alvaro/components/message_card.dart';
import 'package:proyecto_seminario_alvaro/components/message_form.dart';
import 'package:proyecto_seminario_alvaro/logic/messages.dart';
import 'package:proyecto_seminario_alvaro/logic/templates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/nav_args.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Screen with the messages of an edition, their send dates and previews.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late EventSeries _series;
  late Edition _edition;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments as EditionArgs;
      _series = args.series;
      _edition = args.edition;
      _initialized = true;
    }
  }

  bool get _canEdit => _edition.status != 'closed';

  void _toggleSent(EventMessage message) {
    setState(() {
      _edition = _edition.copyWith(
        messages: [
          for (final m in _edition.messages)
            m.id == message.id ? m.copyWith(sent: !m.sent) : m,
        ],
      );
    });
  }

  void _deleteMessage(EventMessage message) {
    setState(() {
      _edition = _edition.copyWith(
        messages: _edition.messages.where((m) => m.id != message.id).toList(),
      );
    });
  }

  void _addMessage(EventMessage message) {
    setState(() {
      _edition = _edition.copyWith(
        messages: [..._edition.messages, message],
      );
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
    final values = messageValues(_series, _edition);
    final messages = sortedMessages(_edition.messages);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mensajes · Edición ${_edition.number}'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _edition),
        ),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${sentCount(_edition)} de ${_edition.messages.length} enviados',
              style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 4),
            Text(
              'La app no envía mensajes: copia el texto a tu canal y márcalo como enviado.',
              style: textTheme.bodySmall?.copyWith(color: AppColors.mutedText),
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
            if (messages.isEmpty)
              const EmptyMessage(text: 'Esta edición no tiene mensajes.')
            else
              for (final message in messages)
                MessageCard(
                  message: message,
                  typeLabel: messageTypeLabel(message.type),
                  sendDateText: messageSendText(message, _edition.dateTime),
                  statusText:
                      messageStatusText(message, _edition.dateTime, today),
                  subject: fillTemplate(message.subject, values),
                  preview: fillTemplate(message.body, values),
                  canEdit: _canEdit,
                  onToggleSent: () => _toggleSent(message),
                  onDelete: () => _deleteMessage(message),
                ),
            if (_canEdit) ...[
              const SizedBox(height: 16),
              MessageForm(onAdd: (message) => _addMessage(message)),
            ],
          ],
        ),
      ),
    );
  }
}
