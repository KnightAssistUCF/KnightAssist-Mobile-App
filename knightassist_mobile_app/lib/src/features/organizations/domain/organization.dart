import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';

class Organization extends AppUser {
  const Organization(
      {required super.id,
      super.type = "organization",
      required this.name,
      required super.email,
      required this.description,
      required this.logoUrl,
      required this.category,
      required this.followers,
      required this.favorites,
      required this.updates,
      required this.calendarLink,
      required this.isActive,
      required this.eventHappeningNow,
      required this.backgroundUrl,
      required this.events,
      required this.semesters,
      required this.recoveryToken,
      required this.confirmToken,
      required this.emailToken,
      required this.emailValidated,
      required this.createdAt,
      required this.updatedAt});

  final String name;
  final String description;
  final String logoUrl;
  final List<String> category;
  final List<String> followers;
  final List<String> favorites;
  final List<Update> updates;
  final String? calendarLink;
  final bool isActive;
  final bool eventHappeningNow;
  final String? backgroundUrl;
  final List<String> events;
  final List<String> semesters;
  final String? recoveryToken;
  final String confirmToken;
  final String emailToken;
  final bool emailValidated;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
        id: map['_id'],
        name: map['name'],
        email: map['email'],
        description: map['description'],
        logoUrl: map['logoUrl'] as String,
        category: List<String>.from(map['category']),
        followers: List<String>.from(map['followers']),
        favorites: List<String>.from(map['favorites']),
        updates: List<Update>.from(map['updates']),
        calendarLink: map['calendarLink'] as String?,
        isActive: map['isActive'],
        eventHappeningNow: map['eventHappeningNow'],
        backgroundUrl: map['backgroundUrl'] as String?,
        events: List<String>.from(map['events']),
        semesters: List<String>.from(map['semesters']),
        recoveryToken: map['recoveryToken'],
        confirmToken: map['confirmToken'],
        emailToken: map['emailToken'],
        emailValidated: map['emailValidated'],
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'email': email,
        'description': description,
        'logoUrl': logoUrl,
        'category': category,
        'followers': followers,
        'favorites': favorites,
        'updates': updates,
        'calendarLink': calendarLink,
        'isActive': isActive,
        'eventHappeningNow': eventHappeningNow,
        'backgroundURL': backgroundUrl,
        'events': events,
        'semesters': semesters,
        'recoveryToken': recoveryToken,
        'confirmToken': confirmToken,
        'emailToken': emailToken,
        'emailValidated': emailValidated,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
