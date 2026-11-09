/// A calculated recommendation for an edition (not persisted).
class Recommendation {
  final String rule; // 'R1', 'R2', 'R3', 'R4', 'R5'
  final String reference;
  final String title;
  final String evidence;
  final String actionLabel;
  final int? value;
  final List<String> people; // 'Name · email'

  const Recommendation({
    required this.rule,
    required this.reference,
    required this.title,
    required this.evidence,
    required this.actionLabel,
    this.value,
    this.people = const [],
  });

  /// Returns a copy with the given fields replaced.
  Recommendation copyWith({
    String? rule,
    String? reference,
    String? title,
    String? evidence,
    String? actionLabel,
    int? value,
    List<String>? people,
  }) {
    return Recommendation(
      rule: rule ?? this.rule,
      reference: reference ?? this.reference,
      title: title ?? this.title,
      evidence: evidence ?? this.evidence,
      actionLabel: actionLabel ?? this.actionLabel,
      value: value ?? this.value,
      people: people ?? this.people,
    );
  }
}
