// To parse this JSON data, do
//
//     final org = organizationFromJson(jsonString);

import 'dart:convert';

import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';

Organization organizationFromJson(String str) =>
    Organization.fromJson(json.decode(str));

String organizationToJson(Organization data) => json.encode(data.toJson());

class Organization extends AppUser {
  Contact? contact;
  String id;
  String? organizationId;
  String name;
  String password;
  String email;
  String? description;
  String logoUrl;
  List<String> categoryTags;
  List<dynamic> followers;
  List<String> favorites;
  List<Update> updates;
  String? calendarLink;
  bool isActive;
  bool eventHappeningNow;
  String backgroundUrl;
  List<dynamic> eventsArray;
  String? location;
  //List<dynamic> organizationSemesters;
  dynamic recoveryTokenForOrg;
  String confirmTokenForOrg;
  String emailTokenForOrg;
  bool emailValidated;
  String v;
  DateTime createdAt;
  DateTime updatedAt;
  String profilePicPath;
  String role;
  bool firstTimeLogin;

  Organization({
    this.contact,
    required this.id,
    this.organizationId,
    required this.name,
    required this.password,
    required this.email,
    this.description,
    required this.logoUrl,
    required this.categoryTags,
    required this.followers,
    required this.favorites,
    required this.updates,
    this.calendarLink,
    required this.isActive,
    required this.eventHappeningNow,
    required this.backgroundUrl,
    required this.eventsArray,
    this.location,
    //required this.organizationSemesters,
    required this.recoveryTokenForOrg,
    required this.confirmTokenForOrg,
    required this.emailTokenForOrg,
    required this.emailValidated,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePicPath,
    required this.role,
    required this.firstTimeLogin,
  }) : super(id: '', email: '', role: '');

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        contact: Contact.fromJson(json["contact"]),
        id: json["_id"],
        organizationId: json["organizationID"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
        description: json["description"],
        logoUrl: json["logoUrl"],
        categoryTags: List<String>.from(json["categoryTags"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        favorites: List<String>.from(json["favorites"].map((x) => x)),
        updates:
            List<Update>.from(json["updates"].map((x) => Update.fromJson(x))),
        calendarLink: json["calendarLink"],
        isActive: json["isActive"],
        eventHappeningNow: json["eventHappeningNow"],
        backgroundUrl: json["backgroundURL"],
        eventsArray: List<dynamic>.from(json["eventsArray"].map((x) => x)),
        location: json["location"],
        //organizationSemesters:
        //List<dynamic>.from(json["organizationSemesters"].map((x) => x)),
        recoveryTokenForOrg: json["recoveryTokenForORG"],
        confirmTokenForOrg: json["confirmTokenForORG"],
        emailTokenForOrg: json["EmailTokenForORG"],
        emailValidated: json["EmailValidated"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        profilePicPath: json["profilePicPath"],
        role: json["role"],
        firstTimeLogin: json["firstTimeLogin"],
      );

  Map<String, dynamic> toJson() => {
        "contact": contact?.toJson(),
        "_id": id,
        "organizationID": organizationId,
        "name": name,
        "password": password,
        "email": email,
        "description": description,
        "logoUrl": logoUrl,
        "categoryTags": List<dynamic>.from(categoryTags.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "favorites": List<dynamic>.from(favorites.map((x) => x)),
        "updates": List<dynamic>.from(updates.map((x) => x.toJson())),
        "calendarLink": calendarLink,
        "isActive": isActive,
        "eventHappeningNow": eventHappeningNow,
        "backgroundURL": backgroundUrl,
        "eventsArray": List<dynamic>.from(eventsArray.map((x) => x)),
        "location": location,
        //"organizationSemesters":
        //List<dynamic>.from(organizationSemesters.map((x) => x)),
        "recoveryTokenForORG": recoveryTokenForOrg,
        "confirmTokenForORG": confirmTokenForOrg,
        "EmailTokenForORG": emailTokenForOrg,
        "EmailValidated": emailValidated,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "profilePicPath": profilePicPath,
        "role": role,
        "firstTimeLogin": firstTimeLogin,
      };
}

class Contact {
  SocialMedia? socialMedia;
  String? email;
  String? phone;
  String? website;

  Contact({
    this.socialMedia,
    this.email,
    this.phone,
    this.website,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        socialMedia: SocialMedia.fromJson(json["socialMedia"]),
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "socialMedia": socialMedia?.toJson(),
        "email": email,
        "phone": phone,
        "website": website,
      };
}

class SocialMedia {
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;

  SocialMedia({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        linkedin: json["linkedin"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "linkedin": linkedin,
      };
}

class Update {
  String title;
  String content;
  DateTime date;
  String id;

  Update({
    required this.title,
    required this.content,
    required this.date,
    required this.id,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
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


/*class Organization {
  List<Null>? categoryTags;
  String? profilePicPath;
  String? backgroundURL;
  List<Null>? eventsArray;
  List<Null>? organizationSemesters;
  Null? recoveryTokenForORG;
  String? confirmTokenForORG;
  String? emailTokenForORG;
  bool? emailValidated;
  String? role;
  bool? firstTimeLogin;
  String? sId;
  String? name;
  String? password;
  String? email;
  String? description;
  String? logoUrl;
  List<String>? category;
  List<Null>? events;
  List<Null>? followers;
  List<Null>? favorites;
  List<Updates>? updates;
  bool? isActive;
  bool? eventHappeningNow;
  String? createdAt;
  String? updatedAt;
  String? sV;

  Organization(
      {this.categoryTags,
      this.profilePicPath,
      this.backgroundURL,
      this.eventsArray,
      this.organizationSemesters,
      this.recoveryTokenForORG,
      this.confirmTokenForORG,
      this.emailTokenForORG,
      this.emailValidated,
      this.role,
      this.firstTimeLogin,
      this.sId,
      this.name,
      this.password,
      this.email,
      this.description,
      this.logoUrl,
      this.category,
      this.events,
      this.followers,
      this.favorites,
      this.updates,
      this.isActive,
      this.eventHappeningNow,
      this.createdAt,
      this.updatedAt,
      this.sV});

  Organization.fromJson(Map<String, dynamic> json) {
    if (json['categoryTags'] != null) {
      categoryTags = <Null>[];
      json['categoryTags'].forEach((v) {
        categoryTags!.add(new Null.fromJson(v));
      });
    }
    profilePicPath = json['profilePicPath'];
    backgroundURL = json['backgroundURL'];
    if (json['eventsArray'] != null) {
      eventsArray = <Null>[];
      json['eventsArray'].forEach((v) {
        eventsArray!.add(new Null.fromJson(v));
      });
    }
    if (json['organizationSemesters'] != null) {
      organizationSemesters = <Null>[];
      json['organizationSemesters'].forEach((v) {
        organizationSemesters!.add(new Null.fromJson(v));
      });
    }
    recoveryTokenForORG = json['recoveryTokenForORG'];
    confirmTokenForORG = json['confirmTokenForORG'];
    emailTokenForORG = json['EmailTokenForORG'];
    emailValidated = json['EmailValidated'];
    role = json['role'];
    firstTimeLogin = json['firstTimeLogin'];
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    description = json['description'];
    logoUrl = json['logoUrl'];
    category = json['category'].cast<String>();
    if (json['events'] != null) {
      events = <Null>[];
      json['events'].forEach((v) {
        events!.add(new Null.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = <Null>[];
      json['followers'].forEach((v) {
        followers!.add(new Null.fromJson(v));
      });
    }
    if (json['favorites'] != null) {
      favorites = <Null>[];
      json['favorites'].forEach((v) {
        favorites!.add(new Null.fromJson(v));
      });
    }
    if (json['updates'] != null) {
      updates = <Updates>[];
      json['updates'].forEach((v) {
        updates!.add(new Updates.fromJson(v));
      });
    }
    isActive = json['isActive'];
    eventHappeningNow = json['eventHappeningNow'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryTags != null) {
      data['categoryTags'] = this.categoryTags!.map((v) => v.toJson()).toList();
    }
    data['profilePicPath'] = this.profilePicPath;
    data['backgroundURL'] = this.backgroundURL;
    if (this.eventsArray != null) {
      data['eventsArray'] = this.eventsArray!.map((v) => v.toJson()).toList();
    }
    if (this.organizationSemesters != null) {
      data['organizationSemesters'] =
          this.organizationSemesters!.map((v) => v.toJson()).toList();
    }
    data['recoveryTokenForORG'] = this.recoveryTokenForORG;
    data['confirmTokenForORG'] = this.confirmTokenForORG;
    data['EmailTokenForORG'] = this.emailTokenForORG;
    data['EmailValidated'] = this.emailValidated;
    data['role'] = this.role;
    data['firstTimeLogin'] = this.firstTimeLogin;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['description'] = this.description;
    data['logoUrl'] = this.logoUrl;
    data['category'] = this.category;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.favorites != null) {
      data['favorites'] = this.favorites!.map((v) => v.toJson()).toList();
    }
    if (this.updates != null) {
      data['updates'] = this.updates!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = this.isActive;
    data['eventHappeningNow'] = this.eventHappeningNow;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.sV;
    return data;
  }
}

class Updates {
  String? sId;
  String? date;

  Updates({this.sId, this.date});

  Updates.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    return data;
  }
}*/

/*import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/contact.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';

class Organization extends AppUser {
  const Organization(
      {required super.id,
      super.role = "organization",
      required this.name,
      required super.email,
      required this.description,
      required this.contact,
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
      required this.location,
      required this.semesters,
      required this.recoveryToken,
      required this.confirmToken,
      required this.emailToken,
      required this.emailValidated,
      required this.createdAt,
      required this.updatedAt});

  final String name;
  final String description;
  final Contact contact;
  final String logoUrl;
  final List<String> category;
  final List<String> followers;
  final List<String> favorites;
  final List<Update> updates;
  final String? calendarLink;
  final bool isActive;
  final bool eventHappeningNow;
  final String backgroundUrl;
  final List<String> events;
  final String location;
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
        contact: map['contact'] as Contact,
        logoUrl: map['logoUrl'] as String,
        category: List<String>.from(map['category']),
        followers: List<String>.from(map['followers']),
        favorites: List<String>.from(map['favorites']),
        updates: List<Update>.from(map['updates']),
        calendarLink: map['calendarLink'] as String?,
        isActive: map['isActive'],
        eventHappeningNow: map['eventHappeningNow'],
        backgroundUrl: map['backgroundUrl'] as String,
        events: List<String>.from(map['events']),
        location: map['location'],
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
        'contact': contact,
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
        'location': location,
        'semesters': semesters,
        'recoveryToken': recoveryToken,
        'confirmToken': confirmToken,
        'emailToken': emailToken,
        'emailValidated': emailValidated,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}*/
