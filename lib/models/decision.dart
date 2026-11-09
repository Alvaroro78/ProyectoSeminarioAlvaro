/// A decision on a recommendation for an edition.
class Decision {
  final String rule; // 'R1', 'R2', 'R3', 'R4', 'R5'
  final String reference;
  final bool accepted;
  final DateTime decidedAt;

  const Decision({
    required this.rule,
    required this.reference,
    required this.accepted,
    required this.decidedAt,
  });

  /// Returns a copy with the given fields replaced.
  Decision copyWith({
    String? rule,
    String? reference,
    bool? accepted,
    DateTime? decidedAt,
  }) {
    return Decision(
      rule: rule ?? this.rule,
      reference: reference ?? this.reference,
      accepted: accepted ?? this.accepted,
      decidedAt: decidedAt ?? this.decidedAt,
    );
  }
}
