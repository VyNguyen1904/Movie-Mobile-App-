import 'package:flutter/material.dart';
import '../models/watch_item.dart';
import '../services/local_json_service.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final LocalJsonService storageService = LocalJsonService();

  final TextEditingController searchController = TextEditingController();

  List<WatchItem> watchlist = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadItems() async {
    final items = await storageService.loadWatchlist();

    setState(() {
      watchlist = items;
      isLoading = false;
    });
  }

  Future<void> saveItems() async {
    await storageService.saveWatchlist(watchlist);
  }

  int generateId() {
    if (watchlist.isEmpty) return 1;

    final ids = watchlist.map((item) => item.id).toList();
    ids.sort();

    return ids.last + 1;
  }

  List<WatchItem> get filteredItems {
    if (searchQuery.isEmpty) return watchlist;

    return watchlist.where((item) {
      return item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.note.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void openItemDialog({WatchItem? item}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final noteController = TextEditingController(text: item?.note ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item == null ? 'Add Watch Item' : 'Edit Watch Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Movie / TV Show Title',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'Note',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final note = noteController.text.trim();

                if (title.isEmpty) return;

                if (item == null) {
                  final newItem = WatchItem(
                    id: generateId(),
                    title: title,
                    note: note,
                  );

                  setState(() {
                    watchlist.add(newItem);
                  });
                } else {
                  setState(() {
                    item.title = title;
                    item.note = note;
                  });
                }

                await saveItems();

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Watchlist saved'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteItem(WatchItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete item?'),
          content: Text('Remove "${item.title}" from watchlist?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  watchlist.removeWhere((element) => element.id == item.id);
                });

                await saveItems();

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item deleted'),
                    ),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Watchlist'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openItemDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search saved movies...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),

            Expanded(
              child: items.isEmpty
                  ? const Center(
                child: Text('No saved items found'),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(item.id.toString()),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item.note.isEmpty
                            ? 'No note'
                            : item.note,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              openItemDialog(item: item);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteItem(item);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}