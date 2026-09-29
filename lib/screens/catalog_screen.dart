import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, this.genre});

  final String? genre;

  @override
  Widget build(BuildContext context) {
    final genres = <String>{for (final book in books) book.genre}.toList()..sort();
    final visibleBooks = genre == null
        ? books
        : books.where((book) => book.genre == genre).toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Каталог')),
      body: Column(
        children: [
          SizedBox(
            height: 58,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('Усі'),
                    selected: genre == null,
                    onSelected: (_) => context.go('/catalog'),
                  ),
                ),
                for (final item in genres)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(item),
                      selected: genre == item,
                      onSelected: (_) => context.go('/catalog?genre=${Uri.encodeQueryComponent(item)}'),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              key: PageStorageKey<String>('catalog-${genre ?? 'all'}'),
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
              itemCount: visibleBooks.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final book = visibleBooks[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text('${book.author} • ${book.genre}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/catalog/book/${book.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
