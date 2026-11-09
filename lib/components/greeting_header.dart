import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Indigo header with a greeting and a short summary.
class GreetingHeader extends StatelessWidget {
  final String greeting;
  final String summary;

  const GreetingHeader({
    super.key,
    required this.greeting,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            greeting,
            style: textTheme.headlineSmall?.copyWith(color: AppColors.surface),
          ),
          Text(
            summary,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.surface.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}
