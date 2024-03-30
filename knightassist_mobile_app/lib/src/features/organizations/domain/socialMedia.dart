import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

class SocialMedia {
  const SocialMedia({
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedIn,
  });

  final String facebook;
  final String twitter;
  final String instagram;
  final String linkedIn;

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      instagram: map['instagram'] ?? '',
      linkedIn: map['linkedin'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'facebook': facebook,
        'twitter': twitter,
        'instagram': instagram,
        'linkedin': linkedIn,
      };
}
