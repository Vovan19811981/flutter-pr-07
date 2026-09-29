import 'package:go_router/go_router.dart';

import 'screens/book_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/login_screen.dart';
import 'state/auth_state.dart';

GoRouter createRouter(AuthState authState) {
  return GoRouter(
    initialLocation: '/catalog',
    refreshListenable: authState,
    redirect: (context, state) {
      final protected = state.uri.path.endsWith('/reserve');
      if (protected && !authState.isLoggedIn) {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/catalog',
        builder: (context, state) => CatalogScreen(
          genre: state.uri.queryParameters['genre'],
        ),
        routes: [
          GoRoute(
            path: 'book/:bookId',
            builder: (context, state) => BookScreen(
              bookId: state.pathParameters['bookId']!,
              authState: authState,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(authState: authState),
      ),
    ],
  );
}
