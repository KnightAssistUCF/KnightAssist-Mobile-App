class AppUser {
  AppUser({this.id, this.recoveryToken, this.email});
  String? id;
  String? recoveryToken;
  String? email;

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    recoveryToken = json['recoveryToken'];
    email = json['email'];
  }
}
