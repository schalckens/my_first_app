import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final TextEditingController _sessionController = TextEditingController();

  void _submitSession() {
    String sessionId = _sessionController.text;

    // Simuler la vérification du numéro de session avec des données en dur
    if (sessionId == '123456') {
      Provider.of<Auth>(context, listen: false).setSessionId(sessionId);
      Navigator.of(context).pop();
    } else {
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Numéro de session invalide')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrer le numéro de session'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Veuillez entrer votre numéro de session',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _sessionController,
              decoration: InputDecoration(
                labelText: 'Numéro de session',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitSession,
              child: Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}
