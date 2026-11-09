/// A registration for an edition.
class Registration {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final String code;
  final DateTime registeredAt;
  final bool attended;
  final Map<String, String> answers;

  const Registration({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.code,
    required this.registeredAt,
    required this.attended,
    required this.answers,
  });

  Registration copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userEmail,
    String? code,
    DateTime? registeredAt,
    bool? attended,
    Map<String, String>? answers,
  }) {
    return Registration(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      code: code ?? this.code,
      registeredAt: registeredAt ?? this.registeredAt,
      attended: attended ?? this.attended,
      answers: answers ?? this.answers,
    );
  }
}
