import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart'
    as prefix;
import 'package:knightassist_mobile_app/src/features/organizations/domain/socialMedia.dart';

typedef UpdateID = String;

class Contact {
  const Contact({
    required this.email,
    required this.phone,
    required this.website,
    required this.socialMedia,
  });

  final String email;
  final String phone;
  final String website;
  final SocialMedia socialMedia;

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      email: map['email'],
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      socialMedia: map['socialMedia'] as SocialMedia,
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'phone': phone,
        'website': website,
        'socialMedia': socialMedia,
      };
}
