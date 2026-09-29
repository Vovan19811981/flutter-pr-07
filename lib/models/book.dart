class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
  });

  final String id;
  final String title;
  final String author;
  final String genre;
  final String description;
}

const books = <Book>[
  Book(id: 'b01', title: 'Clean Code', author: 'Robert C. Martin', genre: 'Programming', description: 'Практичні принципи написання зрозумілого та підтримуваного коду.'),
  Book(id: 'b02', title: 'The Pragmatic Programmer', author: 'Andrew Hunt, David Thomas', genre: 'Programming', description: 'Підходи до професійної розробки програмного забезпечення.'),
  Book(id: 'b03', title: 'Design Patterns', author: 'Erich Gamma et al.', genre: 'Programming', description: 'Класичні шаблони об’єктно-орієнтованого проєктування.'),
  Book(id: 'b04', title: 'Algorithms', author: 'Robert Sedgewick', genre: 'Computer Science', description: 'Алгоритми, структури даних та аналіз складності.'),
  Book(id: 'b05', title: 'Computer Networks', author: 'Andrew S. Tanenbaum', genre: 'Computer Science', description: 'Архітектура та принципи роботи комп’ютерних мереж.'),
  Book(id: 'b06', title: 'Operating System Concepts', author: 'Abraham Silberschatz', genre: 'Computer Science', description: 'Основи побудови та роботи операційних систем.'),
  Book(id: 'b07', title: 'Database System Concepts', author: 'Abraham Silberschatz', genre: 'Databases', description: 'Моделі даних, SQL, транзакції та індекси.'),
  Book(id: 'b08', title: 'SQL Antipatterns', author: 'Bill Karwin', genre: 'Databases', description: 'Типові помилки проєктування та використання SQL.'),
  Book(id: 'b09', title: 'Refactoring', author: 'Martin Fowler', genre: 'Programming', description: 'Покращення структури існуючого коду без зміни поведінки.'),
  Book(id: 'b10', title: 'You Don’t Know JS Yet', author: 'Kyle Simpson', genre: 'Web', description: 'Глибоке пояснення механізмів JavaScript.'),
  Book(id: 'b11', title: 'HTML and CSS', author: 'Jon Duckett', genre: 'Web', description: 'Основи створення вебінтерфейсів.'),
  Book(id: 'b12', title: 'Eloquent JavaScript', author: 'Marijn Haverbeke', genre: 'Web', description: 'Практичне програмування мовою JavaScript.'),
  Book(id: 'b13', title: 'Discrete Mathematics', author: 'Kenneth Rosen', genre: 'Mathematics', description: 'Дискретні структури для інформатики.'),
  Book(id: 'b14', title: 'Linear Algebra', author: 'Gilbert Strang', genre: 'Mathematics', description: 'Матриці, вектори та лінійні перетворення.'),
  Book(id: 'b15', title: 'Introduction to Probability', author: 'Joseph Blitzstein', genre: 'Mathematics', description: 'Основи теорії ймовірностей із прикладами.'),
  Book(id: 'b16', title: 'Don’t Make Me Think', author: 'Steve Krug', genre: 'Design', description: 'Основи зручності та зрозумілості інтерфейсів.'),
  Book(id: 'b17', title: 'The Design of Everyday Things', author: 'Don Norman', genre: 'Design', description: 'Принципи проєктування зрозумілих продуктів.'),
  Book(id: 'b18', title: 'Sprint', author: 'Jake Knapp', genre: 'Design', description: 'Практичний процес швидкої перевірки продуктових ідей.'),
];

Book? findBook(String id) {
  for (final book in books) {
    if (book.id == id) {
      return book;
    }
  }
  return null;
}
