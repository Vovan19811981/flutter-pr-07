class Reservation {
  const Reservation({
    required this.bookId,
    required this.returnDate,
    this.note = '',
  });

  final String bookId;
  final DateTime returnDate;
  final String note;
}
