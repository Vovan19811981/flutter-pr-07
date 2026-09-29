import 'package:flutter/material.dart';

import '../state/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.authState});

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вхід')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_library_outlined, size: 72),
                const SizedBox(height: 20),
                const Text('Для бронювання книги потрібно увійти.'),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: authState.login,
                  child: const Text('Увійти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
