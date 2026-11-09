import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/recommendation.dart';

/// A card presenting a data-backed recommendation with accept and discard actions.
class RecommendationCard extends StatelessWidget {
  final Recommendation recommendation;
  final Function() onAccept;
  final Function() onDiscard;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.onAccept,
    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3DC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0C572)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: Color(0xFFA96C05),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  recommendation.title,
                  style: const TextStyle(
                    color: Color(0xFFA96C05),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recommendation.evidence,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          if (recommendation.people.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final person in recommendation.people)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline,
                              size: 14, color: Color(0xFFA96C05)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              person,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => onDiscard(),
                child: const Text('Descartar'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => onAccept(),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFA96C05),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
