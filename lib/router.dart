import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/book_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/error_screen.dart';
import 'screens/login_screen.dart';
import 'screens/my_books_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reserve_screen.dart';
import 'screens/return_date_screen.dart';
import 'state/auth_state.dart';
import 'state/library_state.dart';
import 'widgets/library_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _catalogNavigatorKey = GlobalKey<NavigatorState>();
final _booksNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthState authState, LibraryState libraryState) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/catalog',
    refreshListenable: authState,
    redirect: (context, state) {
      final isReserve = state.uri.path.endsWith('/reserve');
      final isLogin = state.uri.path == '/login';
      if (!authState.isLoggedIn && isReserve) {
        final from = Uri.encodeQueryComponent(state.uri.toString());
        return '/login?from=$from';
      }
      if (authState.isLoggedIn && isLogin) {
        return state.uri.queryParameters['from'] ?? '/catalog';
      }
      return null;
    },
    errorBuilder: (context, state) => ErrorScreen(message: state.error?.toString() ?? state.uri.toString()),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => LibraryShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _catalogNavigatorKey,
            routes: [
              GoRoute(
                path: '/catalog',
                builder: (context, state) => CatalogScreen(genre: state.uri.queryParameters['genre']),
                routes: [
                  GoRoute(
                    path: 'book/:bookId',
                    builder: (context, state) => BookScreen(
                      bookId: state.pathParameters['bookId']!,
                      authState: authState,
                    ),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'reserve',
                        builder: (context, state) => ReserveScreen(
                          bookId: state.pathParameters['bookId']!,
                          libraryState: libraryState,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _booksNavigatorKey,
            routes: [
              GoRoute(
                path: '/my-books',
                builder: (context, state) => MyBooksScreen(libraryState: libraryState),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => ProfileScreen(
                  authState: authState,
                  libraryState: libraryState,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/login',
        builder: (context, state) => LoginScreen(authState: authState),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/date-picker',
        builder: (context, state) => const ReturnDateScreen(),
      ),
    ],
  );
}
