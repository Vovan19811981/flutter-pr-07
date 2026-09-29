import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryShell extends StatelessWidget {
  const LibraryShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Каталог'),
          NavigationDestination(icon: Icon(Icons.bookmark_outline), label: 'Мої книги'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Профіль'),
        ],
      ),
    );
  }
}
