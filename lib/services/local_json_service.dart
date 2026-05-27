import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/watch_item.dart';

class LocalJsonService {
  static const String fileName = 'watchlist.json';

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  Future<List<WatchItem>> loadWatchlist() async {
    try {
      final file = await _getLocalFile();

      if (!await file.exists()) {
        await file.writeAsString(jsonEncode([]));
      }

      final content = await file.readAsString();

      final List<dynamic> jsonList = jsonDecode(content);

      return jsonList.map((item) {
        return WatchItem.fromJson(item);
      }).toList();
    } catch (error) {
      return [];
    }
  }

  Future<void> saveWatchlist(List<WatchItem> items) async {
    final file = await _getLocalFile();

    final jsonList = items.map((item) {
      return item.toJson();
    }).toList();

    await file.writeAsString(jsonEncode(jsonList));
  }
}