import 'package:flutter/material.dart';

import '../state/auth_state.dart';
import '../state/library_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.authState,
    required this.libraryState,
  });

  final AuthState authState;
  final LibraryState libraryState;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _cardController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.libraryState.readerName);
    _cardController = TextEditingController(text: widget.libraryState.cardNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameController.text.trim().isEmpty || _cardController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заповніть ім’я та номер квитка')),
      );
      return;
    }
    widget.libraryState.updateProfile(
      name: _nameController.text,
      cardNumber: _cardController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Профіль збережено')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Ім’я', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _cardController,
            decoration: const InputDecoration(labelText: 'Номер читацького квитка', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _save, child: const Text('Зберегти')),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: widget.authState,
            builder: (context, _) => OutlinedButton(
              onPressed: widget.authState.isLoggedIn ? widget.authState.logout : widget.authState.login,
              child: Text(widget.authState.isLoggedIn ? 'Вийти з облікового запису' : 'Увійти'),
            ),
          ),
        ],
      ),
    );
  }
}
