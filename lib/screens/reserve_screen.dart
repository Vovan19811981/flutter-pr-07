import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';
import '../models/reservation.dart';
import '../state/library_state.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({
    super.key,
    required this.bookId,
    required this.libraryState,
  });

  final String bookId;
  final LibraryState libraryState;

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  final _noteController = TextEditingController();
  DateTime? _returnDate;
  bool _dirty = false;
  bool _allowPop = false;

  @override
  void initState() {
    super.initState();
    _noteController.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_dirty && _noteController.text.isNotEmpty) {
      setState(() => _dirty = true);
    }
  }

  @override
  void dispose() {
    _noteController
      ..removeListener(_markDirty)
      ..dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final result = await context.push<DateTime>('/date-picker');
    if (!mounted || result == null) {
      return;
    }
    setState(() {
      _returnDate = result;
      _dirty = true;
    });
  }

  Future<void> _confirmDiscard() async {
    final discard = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Вийти без збереження?'),
            content: const Text('Незбережені зміни буде втрачено.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Залишитися')),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Вийти')),
            ],
          ),
        ) ??
        false;
    if (!mounted || !discard) {
      return;
    }
    _allowAndPop();
  }


  void _allowAndPop() {
    setState(() => _allowPop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.pop();
      }
    });
  }

  void _reserve() {
    final date = _returnDate;
    if (date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Оберіть дату повернення')),
      );
      return;
    }
    widget.libraryState.reserve(
      Reservation(
        bookId: widget.bookId,
        returnDate: date,
        note: _noteController.text.trim(),
      ),
    );
    _allowAndPop();
  }

  @override
  Widget build(BuildContext context) {
    final book = findBook(widget.bookId);
    return PopScope(
      canPop: !_dirty || _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _dirty && !_allowPop) {
          _confirmDiscard();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Бронювання')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(book?.title ?? 'Книга', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: const Text('Дата повернення'),
              subtitle: Text(_returnDate == null
                  ? 'Не обрано'
                  : "${_returnDate!.day.toString().padLeft(2, '0')}.${_returnDate!.month.toString().padLeft(2, '0')}.${_returnDate!.year}"),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectDate,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Примітка',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: _reserve, child: const Text('Підтвердити бронювання')),
          ],
        ),
      ),
    );
  }
}
