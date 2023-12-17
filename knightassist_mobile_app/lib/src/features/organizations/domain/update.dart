typedef UpdateID = String;

class Update {
  const Update({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  final UpdateID id;
  final String title;
  final String content;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Update.fromMap(Map<String, dynamic> map) {
    return Update(
        id: map['id'] as String,
        title: map['title'],
        content: map['content'] ?? '',
        date: DateTime.parse(map['date']),
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
