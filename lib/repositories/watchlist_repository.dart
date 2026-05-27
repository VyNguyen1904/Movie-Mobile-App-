import '../models/watch_item.dart';

class WatchlistRepository {
  final List<WatchItem> _items = [];

  List<WatchItem> get items => List.unmodifiable(_items);

  void addItem(WatchItem item) {
    _items.add(item);
  }

  void deleteItem(int id) {
    _items.removeWhere((item) => item.id == id);
  }

  void updateItem({
    required int id,
    required String title,
    required String note,
  }) {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) return;

    _items[index].title = title;
    _items[index].note = note;
  }

  void clear() {
    _items.clear();
  }
}