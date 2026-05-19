import 'package:draksy/core/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toSnakeCase', () {
    test('converts spaced string to snake_case', () {
      expect('Hello World'.toSnakeCase(), equals('hello_world'));
    });

    test('already snake_case string stays unchanged', () {
      expect('already_snake'.toSnakeCase(), equals('already_snake'));
    });

    test('converts UPPER CASE to snake_case', () {
      expect('UPPER CASE'.toSnakeCase(), equals('upper_case'));
    });

    test('empty string returns empty string', () {
      expect(''.toSnakeCase(), equals(''));
    });

    test('single word with no spaces returns lowercased word', () {
      expect('single'.toSnakeCase(), equals('single'));
    });

    test('multiple spaces each become underscores', () {
      expect('multiple   spaces'.toSnakeCase(), equals('multiple___spaces'));
    });

    test('mixed case with multiple words', () {
      expect(
          'Greetings And Intros'.toSnakeCase(),
          equals(
            'greetings_and_intros',
          ));
    });
  });
}
