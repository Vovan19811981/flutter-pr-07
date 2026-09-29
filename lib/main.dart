import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';
import 'state/auth_state.dart';
import 'state/library_state.dart';

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatefulWidget {
  const LibraryApp({super.key});

  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  late final AuthState _authState;
  late final LibraryState _libraryState;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authState = AuthState();
    _libraryState = LibraryState();
    _router = createRouter(_authState, _libraryState);
  }

  @override
  void dispose() {
    _router.dispose();
    _authState.dispose();
    _libraryState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'College Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
