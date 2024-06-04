// models/selection.dart
import 'user.dart';
import 'book.dart';
import 'session.dart';

class Selection {
  final User user;
  final Book book;
  final Session session;

  Selection({
    required this.user,
    required this.book,
    required this.session,
  });

  factory Selection.fromJson(Map<String, dynamic> json) {
    return Selection(
      user: User.fromJson(json['user']),
      book: Book.fromJson(json['book']),
      session: Session.fromJson(json['session']),
    );
  }
}