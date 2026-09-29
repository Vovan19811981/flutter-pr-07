import 'package:flutter/foundation.dart';

import '../models/reservation.dart';

class LibraryState extends ChangeNotifier {
  String _readerName = 'Ірина Коваль';
  String _cardNumber = 'LIB-1024';
  final List<Reservation> _reservations = <Reservation>[];

  String get readerName => _readerName;
  String get cardNumber => _cardNumber;
  List<Reservation> get reservations => List.unmodifiable(_reservations);

  void updateProfile({required String name, required String cardNumber}) {
    _readerName = name.trim();
    _cardNumber = cardNumber.trim();
    notifyListeners();
  }

  void reserve(Reservation reservation) {
    _reservations.removeWhere((item) => item.bookId == reservation.bookId);
    _reservations.add(reservation);
    notifyListeners();
  }
}
