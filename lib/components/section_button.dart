import 'package:flutter/material.dart';

/// A button representing a major section with an icon, title, detail and tap action.
class SectionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final Function() onTap;

  const SectionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(detail),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => onTap(),
      ),
    );
  }
}
