import 'package:flutter/material.dart';
import 'author.dart';

// models/book.dart
class Book {
  final int id;
  final String title;
  final String coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      coverUrl: json['coverUrl'],
    );
  }
}