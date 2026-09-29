import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';
import '../state/auth_state.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({
    super.key,
    required this.bookId,
    required this.authState,
  });

  final String bookId;
  final AuthState authState;

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
          Icon(Icons.menu_book, size: 92, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 20),
          Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(book.author, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Chip(label: Text(book.genre)),
          const SizedBox(height: 16),
          Text(book.description),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: () => context.push('/catalog/book/${book.id}/reserve'),
            icon: const Icon(Icons.event_available),
            label: Text(authState.isLoggedIn ? 'Забронювати' : 'Увійти та забронювати'),
          ),
        ],
      ),
    );
  }
}
