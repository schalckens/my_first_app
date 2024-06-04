// models/session.dart
class Session {
  final int id;
  final int year;
  final int month;
  final DateTime creationDate;

  Session({
    required this.id,
    required this.year,
    required this.month,
    required this.creationDate,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      year: json['year'],
      month: json['month'],
      creationDate: DateTime.parse(json['creation_date']),
    );
  }
}