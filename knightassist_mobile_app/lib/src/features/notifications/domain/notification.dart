class Notification {
  String message;
  String type_is;
  DateTime createdAt;
  bool read;

  Notification({
    required this.message,
    required this.type_is,
    required this.createdAt,
    required this.read,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        message: json["message"],
        type_is: json["type_is"],
        createdAt: DateTime.parse(json["createdAt"]),
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "type_is": type_is,
        "createdAt": createdAt.toIso8601String(),
        "read": read,
      };
}