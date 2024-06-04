import 'package:flutter/material.dart';

// models/user.dart
class User {
  final int id;
  final String username;
  final String password;
  final DateTime registrationDate;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.registrationDate,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      registrationDate: DateTime.parse(json['registration_date']),
      role: json['role'],
    );
  }
}