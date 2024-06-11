import 'package:flutter/material.dart';

class ClassementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
