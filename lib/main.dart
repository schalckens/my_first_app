import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io'; // Import nécessaire pour vérifier la plateforme
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'models/book.dart'; // Importer le modèle Book
import 'models/author.dart'; // Importer le modèle Author


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
        title: const Text('Lecture du Mois'),
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


class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final List<String> genres = ['Fiction', 'Romance', 'Science-fiction'];
  late Map<String, List<Book>> recommendations;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    recommendations = {};

    for (String genre in genres) {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos?_limit=10'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        recommendations[genre] = data.map((json) => Book.fromJson({
          'id': json['id'],
          'title': json['title'],
          'coverUrl': json['url'],
        })).toList();
      } else {
        throw Exception('Failed to load recommendations');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                            final book = recommendations[genres[index]]![subIndex];
                            return Container(
                              width: 100,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(book.coverUrl, height: 80, fit: BoxFit.cover),
                                  SizedBox(height: 5),
                                  Text(
                                    book.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
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

class VoterPage extends StatefulWidget {
  @override
  _VoterPageState createState() => _VoterPageState();
}

class _VoterPageState extends State<VoterPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result; // Déclarer comme nullable
  QRViewController? controller; // QRViewController peut également être nullable

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                  if (result != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lien scanné: ${result!.code}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Classement Final des 5 Livres Sélectionnés',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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