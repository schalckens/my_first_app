import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

  List<Widget> _pages = <Widget>[
    AccueilPage(),
    SelectionPage(),
    ClassementPage(),
    VoterPage(),
    ConnexionPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My First App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Connexion',
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

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listes de recommandations fictives pour démonstration
    final List<String> genres = ['Fiction', 'Romance', 'Science-fiction'];
    final Map<String, List<String>> recommendations = {
      'Fiction': ['Livre A', 'Livre B', 'Livre C'],
      'Romance': ['Livre X', 'Livre Y', 'Livre Z'],
      'Science-fiction': ['Livre P', 'Livre Q', 'Livre R'],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommandations par Genre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        genres[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recommendations[genres[index]]!.length,
                          itemBuilder: (context, subIndex) {
                            return Container(
                              width: 100,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  recommendations[genres[index]]![subIndex],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            Text(
              'Suggestions de Livres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Livre ${index + 1}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String?> _selections = [null, null, null, null];

  void _addSelection(String selection) {
    setState(() {
      for (int i = 0; i < _selections.length; i++) {
        if (_selections[i] == null) {
          _selections[i] = selection;
          break;
        }
      }
    });
  }

  void _removeSelection(int index) {
    setState(() {
      _selections[index] = null;
    });
  }

  void _validateSelections() {
    // Logique de validation
    print('Sélections validées: $_selections');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélection'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Recherche',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logique d'ajout (à adapter selon votre application)
                _addSelection(_searchController.text);
                _searchController.clear();
              },
              child: Text('Ajouter à la sélection'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: _selections.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _removeSelection(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selections[index] == null
                            ? Colors.grey[300]
                            : Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selections[index] == null
                              ? Colors.grey
                              : Colors.blue,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              _selections[index] ?? 'Vide',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _selections[index] == null
                                    ? Colors.black
                                    : Colors.blue,
                              ),
                            ),
                          ),
                          if (_selections[index] != null)
                            Positioned(
                              top: 5,
                              left: 5,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeSelection(index),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _validateSelections,
              child: Text('Valider les sélections'),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listes de livres fictives pour démonstration
    final List<String> top5Books = [
      'Livre 1',
      'Livre 2',
      'Livre 3',
      'Livre 4',
      'Livre 5',
    ];

    final List<String> allBooks = [
      'Livre A',
      'Livre B',
      'Livre C',
      'Livre D',
      'Livre E',
      'Livre F',
      'Livre G',
      'Livre H',
      'Livre I',
      'Livre J',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classement'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top 5 Livres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: top5Books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                    backgroundColor: Colors.blue[100],
                  ),
                  title: Text(top5Books[index]),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Tous les Livres Sélectionnés',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: allBooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text(allBooks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder pour le scan de QR code
    Widget qrCodeScanner = Container(
      width: double.infinity,
      height: 200,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Placeholder pour le scan de QR code',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );

    // Placeholder pour le classement final des 5 livres sélectionnés
    Widget finalRanking = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Classement Final des 5 Livres Sélectionnés',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
                backgroundColor: Colors.blue[100],
              ),
              title: Text('Livre ${index + 1}'),
            );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voter'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scanner le QR Code pour Voter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            qrCodeScanner,
            SizedBox(height: 20),
            finalRanking,
          ],
        ),
      ),
    );
  }
}

class ConnexionPage extends StatelessWidget {
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
              decoration: InputDecoration(
                labelText: 'Identifiant',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique de connexion à ajouter ici
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}