import 'package:college_library/models/book.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('book lookup works without extra data', () {
    expect(findBook('b01')?.title, 'Clean Code');
    expect(findBook('missing'), isNull);
  });
}
