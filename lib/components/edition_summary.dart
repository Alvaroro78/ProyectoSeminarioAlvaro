import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/status_chip.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// A summary banner showing the key metrics and status of an edition.
class EditionSummary extends StatelessWidget {
  final int inscritos;
  final int cupo;
  final int capacidad;
  final int reusedPercent;
  final String estado;

  const EditionSummary({
    super.key,
    required this.inscritos,
    required this.cupo,
    required this.capacidad,
    required this.reusedPercent,
    required this.estado,
  });

  Widget _metric(TextTheme textTheme, String value, String label) {
    return Expanded(
      child: Column(
        spacing: 4,
        children: [
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(color: AppColors.surface),
          ),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.surface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _separator() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.surface.withValues(alpha: 0.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
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
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Resumen de la edición',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.surface,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: StatusChip(status: estado),
              ),
            ],
          ),
          Row(
            children: [
              _metric(textTheme, '$inscritos / $cupo', 'Inscritos / Cupo'),
              _separator(),
              _metric(textTheme, '$capacidad', 'Capacidad'),
              _separator(),
              _metric(textTheme, '$reusedPercent %', 'Reutilizado'),
            ],
          ),
        ],
      ),
    );
  }
}
