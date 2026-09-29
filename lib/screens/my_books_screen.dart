import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';
import '../state/library_state.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key, required this.libraryState});

  final LibraryState libraryState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мої книги')),
      body: AnimatedBuilder(
        animation: libraryState,
        builder: (context, _) {
          if (libraryState.reservations.isEmpty) {
            return const Center(child: Text('Поки немає бронювань'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: libraryState.reservations.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final reservation = libraryState.reservations[index];
              final book = findBook(reservation.bookId);
              return ListTile(
                title: Text(book?.title ?? reservation.bookId),
                subtitle: Text("Повернути до ${reservation.returnDate.day.toString().padLeft(2, '0')}.${reservation.returnDate.month.toString().padLeft(2, '0')}.${reservation.returnDate.year}"),
                onTap: () => context.push('/catalog/book/${reservation.bookId}'),
              );
            },
          );
        },
      ),
    );
  }
}
