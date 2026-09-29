import 'package:flutter/material.dart';

void main() => runApp(const LibraryApp());

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Бібліотека')),
        body: const Center(child: Text('Каталог')),
      ),
    );
  }
}
