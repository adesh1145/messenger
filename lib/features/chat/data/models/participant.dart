class Participant {
  final String uid;
  final String name;
  final DateTime joinedAt;

  Participant({required this.uid, required this.name, required this.joinedAt});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'joinedAt': joinedAt.toIso8601String()};
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      uid: map['uid'],
      name: map['name'],
      joinedAt: DateTime.parse(map['joinedAt']),
    );
  }
}
