typedef AnnouncementID = String;

class Announcement {
  Announcement({
    required this.title,
    required this.content,
    required this.date,
  });
  final String title;
  final String content;
  final DateTime date;

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
        title: map['title'],
        content: map['content'],
        date: DateTime.parse(map['date']));
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
      };
}
