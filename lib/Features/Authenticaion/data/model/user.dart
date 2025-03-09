class User {
  String? username;
  String? password;
  String? passwordConfirm;
  String? email;

  User(this.username, this.password, this.passwordConfirm, this.email);
  Map<String, dynamic> toJson() {
    Map<String, dynamic> tojsonMap = {
      'usernmae': username,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'email': email
    };

    return tojsonMap;
  }
}
