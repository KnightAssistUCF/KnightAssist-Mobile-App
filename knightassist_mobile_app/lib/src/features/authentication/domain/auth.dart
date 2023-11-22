class Auth {
  const Auth({required this.accessToken});

  final String accessToken;

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(accessToken: map["accessToken"]);
  }

  Map<String, String> toMap() => {"accessToken": accessToken};
}
