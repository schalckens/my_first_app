import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

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
