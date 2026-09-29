import 'package:flutter/material.dart';

import '../models/book.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({
    super.key,
    required this.bookId,
  });

  final String bookId;

  @override
  Widget build(BuildContext context) {
    final book = findBook(bookId);
    if (book == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Книгу не знайдено')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Icon(
            Icons.menu_book,
            size: 92,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(book.author),
          const SizedBox(height: 16),
          Text(book.description),
        ],
      ),
    );
  }
}
