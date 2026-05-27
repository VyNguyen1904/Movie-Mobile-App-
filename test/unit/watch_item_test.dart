import 'package:flutter_test/flutter_test.dart';
import 'package:lab_5/models/watch_item.dart';

void main() {
  group('WatchItem Model Test', () {
    test('should create WatchItem with correct values', () {
      // Arrange
      final item = WatchItem(
        id: 1,
        title: 'Interstellar',
        note: 'Watch again',
      );

      // Act + Assert
      expect(item.id, 1);
      expect(item.title, 'Interstellar');
      expect(item.note, 'Watch again');
    });

    test('should convert WatchItem to JSON correctly', () {
      final item = WatchItem(
        id: 1,
        title: 'Dune',
        note: 'Sci-fi movie',
      );

      final json = item.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Dune');
      expect(json['note'], 'Sci-fi movie');
    });

    test('should create WatchItem from JSON correctly', () {
      final json = {
        'id': 2,
        'title': 'Joker',
        'note': 'Drama movie',
      };

      final item = WatchItem.fromJson(json);

      expect(item.id, 2);
      expect(item.title, 'Joker');
      expect(item.note, 'Drama movie');
    });
  });
}