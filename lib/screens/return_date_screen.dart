import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReturnDateScreen extends StatefulWidget {
  const ReturnDateScreen({super.key});

  @override
  State<ReturnDateScreen> createState() => _ReturnDateScreenState();
}

class _ReturnDateScreenState extends State<ReturnDateScreen> {
  DateTime _selected = DateTime.now().add(const Duration(days: 14));

  @override
  Widget build(BuildContext context) {
    final first = DateTime.now().add(const Duration(days: 1));
    final last = DateTime.now().add(const Duration(days: 60));
    return Scaffold(
      appBar: AppBar(title: const Text('Дата повернення')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CalendarDatePicker(
            initialDate: _selected,
            firstDate: first,
            lastDate: last,
            onDateChanged: (value) => setState(() => _selected = value),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.pop(_selected),
            child: const Text('Обрати дату'),
          ),
        ],
      ),
    );
  }
}
