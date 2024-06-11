import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  void signup() {
    // Logique d'inscription (à implémenter)
    login(); // Pour simplifier, nous connectons directement l'utilisateur après l'inscription
  }
}
