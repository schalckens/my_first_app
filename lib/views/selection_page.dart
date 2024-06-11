import 'package:flutter/material.dart';

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
