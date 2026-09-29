import 'package:go_router/go_router.dart';

import 'screens/book_screen.dart';
import 'screens/catalog_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/catalog',
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
            ),
          ),
        ],
      ),
    ],
  );
}
