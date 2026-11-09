/// A decision on a recommendation for an edition.
class Decision {
  final String rule;
  final String reference;
  final bool accepted;
  final DateTime decidedAt;

  const Decision({
    required this.rule,
    required this.reference,
    required this.accepted,
    required this.decidedAt,
  });

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
