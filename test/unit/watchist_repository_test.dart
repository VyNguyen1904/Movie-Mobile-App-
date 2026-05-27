import 'package:flutter_test/flutter_test.dart';
import 'package:lab_5/models/watch_item.dart';
import 'package:lab_5/repositories/watchlist_repository.dart';

void main() {
  group('WatchlistRepository Test', () {
    late WatchlistRepository repository;

    setUp(() {
      repository = WatchlistRepository();
    });

    test('should add item', () {
      // Arrange
      final item = WatchItem(
        id: 1,
        title: 'Avatar',
        note: 'Watch later',
      );

      // Act
      repository.addItem(item);

      // Assert
      expect(repository.items.length, 1);
      expect(repository.items.first.title, 'Avatar');
    });

    test('should delete item', () {
      final item = WatchItem(
        id: 1,
        title: 'Avatar',
        note: 'Watch later',
      );

      repository.addItem(item);
      repository.deleteItem(1);

      expect(repository.items.length, 0);
    });

    test('should update item', () {
      final item = WatchItem(
        id: 1,
        title: 'Old Title',
        note: 'Old Note',
      );

      repository.addItem(item);

      repository.updateItem(
        id: 1,
        title: 'New Title',
        note: 'New Note',
      );

      expect(repository.items.first.title, 'New Title');
      expect(repository.items.first.note, 'New Note');
    });
  });
}