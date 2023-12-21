import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

typedef UpdateID = String;

class Contact {
  const Contact({
    required this.id,
    required this.email,
    required this.phone,
    required this.website,
    required this.socialMedia,
    required this.createdAt,
    required this.updatedAt,
  });

  final UpdateID id;
  final String title;
  final String content;
  final DateTime date;
  final Organization sponsor;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Update.fromMap(Map<String, dynamic> map) {
    return Update(
        id: map['id'] as String,
        title: map['title'],
        content: map['content'] ?? '',
        date: DateTime.parse(map['date']),
        sponsor: map['organization'] as Organization,
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
        'sponsor': sponsor,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
