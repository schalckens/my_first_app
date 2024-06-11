import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth.dart';
import '../main.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;

  void _toggleFormType() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'superuser' && password == 'admin') {
      Provider.of<Auth>(context, listen: false).login();
    } else {
      print('Identifiant ou mot de passe incorrect');
    }
  }

  void _signup() {
    Provider.of<Auth>(context, listen: false).signup();
  }

  void _logout() {
    Provider.of<Auth>(context, listen: false).logout();
    // Réinitialisez l'index sélectionné après la déconnexion
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(auth.isAuthenticated ? 'Déconnexion' : (_isLogin ? 'Connexion' : 'Inscription')),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: auth.isAuthenticated
            ? Center(
          child: ElevatedButton(
            onPressed: _logout,
            child: Text('Se déconnecter'),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isLogin ? 'Identifiez-vous' : 'Créez un compte',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Identifiant',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLogin ? _login : _signup,
              child: Text(_isLogin ? 'Se connecter' : 'S\'inscrire'),
            ),
            TextButton(
              onPressed: _toggleFormType,
              child: Text(
                _isLogin
                    ? 'Pas de compte? S\'inscrire'
                    : 'Déjà un compte? Se connecter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
