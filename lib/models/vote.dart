// models/vote.dart
import 'user.dart';
import 'book.dart';
import 'session.dart';

class Vote {
  final User user;
  final Book book;
  final Session session;

  Vote({
    required this.user,
    required this.book,
    required this.session,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      user: User.fromJson(json['user']),
      book: Book.fromJson(json['book']),
      session: Session.fromJson(json['session']),
    );
  }
}