/// A question in an edition's registration form.
class RegistrationField {
  final String id;
  final String label;
  final String type; // 'text', 'number', 'yesNo'
  final bool isRequired;
  final int order;
  final bool inherited;

  const RegistrationField({
    required this.id,
    required this.label,
    required this.type,
    required this.isRequired,
    required this.order,
    required this.inherited,
  });

  /// Returns a copy with the given fields replaced.
  RegistrationField copyWith({
    String? id,
    String? label,
    String? type,
    bool? isRequired,
    int? order,
    bool? inherited,
  }) {
    return RegistrationField(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      isRequired: isRequired ?? this.isRequired,
      order: order ?? this.order,
      inherited: inherited ?? this.inherited,
    );
  }
}
