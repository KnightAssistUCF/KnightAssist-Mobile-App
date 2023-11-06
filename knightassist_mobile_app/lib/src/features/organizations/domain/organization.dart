import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';

class Organization extends AppUser {
  List<Semester>? organizationSemesters;
  String? confirmTokenForORG;
  bool? validForORG;
  String? name;
  String? description;
  String? logoUrl;
  List<String>? category;
  List<Event>? events;
  List<StudentUser>? followers;
  List<Updates>? updates;
  bool? isActive;
  bool? eventHappeningNow;
  String? createdAt;
  String? updatedAt;
  String? sV;

  Organization(
      {this.organizationSemesters,
      this.confirmTokenForORG,
      this.validForORG,
      this.name,
      this.description,
      this.logoUrl,
      this.category,
      this.events,
      this.followers,
      this.updates,
      this.isActive,
      this.eventHappeningNow,
      this.createdAt,
      this.updatedAt,
      this.sV});

  Organization.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['organizationSemesters'] != null) {
      organizationSemesters = <Semester>[];
      json['organizationSemesters'].forEach((v) {
        organizationSemesters!.add(Semester.fromJson(v));
      });
    }
    confirmTokenForORG = json['confirmTokenForORG'];
    validForORG = json['validForORG'];
    name = json['name'];
    description = json['description'];
    logoUrl = json['logoUrl'];
    category = json['category'].cast<String>();
    if (json['events'] != null) {
      events = <Event>[];
      json['events'].forEach((v) {
        events!.add(Event.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = <StudentUser>[];
      json['followers'].forEach((v) {
        followers!.add(StudentUser.fromJson(v));
      });
    }
    if (json['updates'] != null) {
      updates = <Updates>[];
      json['updates'].forEach((v) {
        updates!.add(Updates.fromJson(v));
      });
    }
    isActive = json['isActive'];
    eventHappeningNow = json['eventHappeningNow'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (organizationSemesters != null) {
      data['organizationSemesters'] =
          organizationSemesters!.map((v) => v.toJson()).toList();
    }
    data['recoveryTokenForORG'] = recoveryToken;
    data['confirmTokenForORG'] = confirmTokenForORG;
    data['validForORG'] = validForORG;
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['description'] = description;
    data['logoUrl'] = logoUrl;
    data['category'] = category;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    if (followers != null) {
      data['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (updates != null) {
      data['updates'] = updates!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = isActive;
    data['eventHappeningNow'] = eventHappeningNow;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = sV;
    return data;
  }
}

class Updates {
  String? id;
  String? date;

  Updates({this.id, this.date});

  Updates.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['date'] = date;
    return data;
  }
}
