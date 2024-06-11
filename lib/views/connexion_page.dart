import 'package:flutter/material.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Données en dur pour la connexion
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'superuser' && password == 'admin') {
      // Succès de la connexion
      print('Connexion réussie');
    } else {
      // Échec de la connexion
      print('Identifiant ou mot de passe incorrect');
    }

    // Commentaires pour la future implémentation de la connexion via API
    // Future<void> _loginWithAPI() async {
    //   final response = await http.post(
    //     Uri.parse('https://api.example.com/login'),
    //     body: json.encode({
    //       'username': username,
    //       'password': password,
    //     }),
    //     headers: {'Content-Type': 'application/json'},
    //   );

    //   if (response.statusCode == 200) {
    //     print('Connexion réussie');
    //   } else {
    //     print('Échec de la connexion');
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Identifiez-vous',
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
              onPressed: _login,
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
