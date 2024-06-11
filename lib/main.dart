import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/accueil_page.dart';
import 'views/selection_page.dart';
import 'views/classement_page.dart';
import 'views/voter_page.dart';
import 'views/connexion_page.dart';
import 'views/session_page.dart'; // Assurez-vous d'importer la page de session
import 'auth.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => Auth(),
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    final auth = Provider.of<Auth>(context, listen: false);

    if (auth.isAuthenticated) {
      if (index > 0 && index < 4 && auth.sessionId == null) {
        // Rediriger vers la page de session si l'utilisateur est connecté mais n'a pas encore entré de numéro de session
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SessionPage()),
        );
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    List<Widget> _pages = <Widget>[
      AccueilPage(),
      if (auth.isAuthenticated && auth.sessionId != null) ...[
        SelectionPage(),
        ClassementPage(),
        VoterPage(),
      ],
      ConnexionPage(),
    ];

    // Vérifiez l'état de connexion pour mettre à jour l'index sélectionné si nécessaire
    if (!auth.isAuthenticated && _selectedIndex > 1) {
      _selectedIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture du Mois'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          if (auth.isAuthenticated && auth.sessionId != null) ...[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Sélection',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Classement',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.how_to_vote),
              label: 'Voter',
            ),
          ],
          BottomNavigationBarItem(
            icon: Icon(auth.isAuthenticated ? Icons.logout : Icons.login),
            label: auth.isAuthenticated ? 'Déconnexion' : 'Connexion',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
