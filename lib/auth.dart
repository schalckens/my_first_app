import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _sessionId;

  bool get isAuthenticated => _isAuthenticated;
  String? get sessionId => _sessionId;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _sessionId = null;
    notifyListeners();
  }

  void signup() {
    login(); // Pour simplifier, nous connectons directement l'utilisateur après l'inscription
  }

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
    notifyListeners();

    // API call to save sessionId, placeholder for now
    // await http.post('https://api.example.com/setSessionId', body: {'sessionId': sessionId});
  }

  void loadSessionId() {
    // Placeholder for API call to load sessionId, using hardcoded data for now
    // var response = await http.get('https://api.example.com/getSessionId');
    // _sessionId = response.body['sessionId'];
    _sessionId = '123456'; // Hardcoded data for testing
    notifyListeners();
  }
}
