import 'package:flutter/material.dart';
import 'author.dart';

// models/book.dart
class Book {
  final int id;
  final String title;
  final String? description;
  final String? comment;
  final String? mainGenre;
  final String? coverUrl;
  final Author? author;

  Book({
    required this.id,
    required this.title,
    this.description,
    this.comment,
    this.mainGenre,
    this.coverUrl,
    this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      comment: json['comment'],
      mainGenre: json['main_genre'],
      coverUrl: json['cover_url'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }
}