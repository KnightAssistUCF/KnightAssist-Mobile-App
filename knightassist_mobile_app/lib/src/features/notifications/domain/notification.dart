class PushNotification {
  String message;
  String type_is;
  String eventId;
  String orgId;
  String orgName;
  DateTime createdAt;
  bool read;
  String id;

  PushNotification(
      {required this.message,
      required this.type_is,
      required this.eventId,
      required this.orgId,
      required this.orgName,
      required this.createdAt,
      required this.read,
      required this.id});

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      PushNotification(
          message: json["message"],
          type_is: json["type_is"],
          eventId: json["eventId"],
          orgId: json["orgId"],
          orgName: json["orgName"],
          createdAt: DateTime.parse(json["createdAt"]),
          read: json["read"],
          id: json["_id"]);

  Map<String, dynamic> toJson() => {
        "message": message,
        "type_is": type_is,
        "eventId": eventId,
        "orgId": orgId,
        "orgName": orgName,
        "createdAt": createdAt.toIso8601String(),
        "read": read,
        "_id": id
      };
}
