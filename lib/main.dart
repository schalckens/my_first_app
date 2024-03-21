import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: const Text('my first app'),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(249, 248, 123, 181),
      ),
      body: const Center(
        child: Text("Hi !"),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Text("Push")
      ),
    ),
));

