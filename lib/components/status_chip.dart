import 'package:flutter/material.dart';

/// A chip displaying the status of an edition (draft, published, or closed).
class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  Color _color() {
    switch (status) {
      case 'published':
        return const Color(0xFF0F8478);
      case 'closed':
        return const Color(0xFF454C61);
      case 'draft':
      default:
        return const Color(0xFF79809A);
    }
  }

  String _label() {
    switch (status) {
      case 'published':
        return 'Publicada';
      case 'closed':
        return 'Cerrada';
      case 'draft':
      default:
        return 'Borrador';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        _label(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
