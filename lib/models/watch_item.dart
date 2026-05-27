class WatchItem {
  final int id;
  String title;
  String note;

  WatchItem({
    required this.id,
    required this.title,
    required this.note,
  });

  factory WatchItem.fromJson(Map<String, dynamic> json) {
    return WatchItem(
      id: json['id'],
      title: json['title'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
    };
  }
}