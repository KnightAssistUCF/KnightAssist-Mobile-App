typedef AnnouncementID = String;

class Announcement {
  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
  final AnnouncementID id;
  final String title;
  final String content;
  final DateTime date;

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
        id: map['id'] as String,
        title: map['title'],
        content: map['content'],
        date: DateTime.parse(map['date']));
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
      };

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        title: json["title"],
        content: json["content"],
        date: DateTime.parse(json["date"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "date": date.toIso8601String(),
        "_id": id,
      };
}
