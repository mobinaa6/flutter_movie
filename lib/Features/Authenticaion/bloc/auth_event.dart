import 'package:flutter_movie/Features/Authenticaion/data/model/user.dart';

abstract class AuthEvent {}

class AuthRequestRegisterEvent extends AuthEvent {
  User user;

  AuthRequestRegisterEvent(this.user);
}

class AuthRequestLoginEvent extends AuthEvent {
  String username;
  String password;
  AuthRequestLoginEvent(this.username, this.password);
}

class AuthSendEmailEvent extends AuthEvent {
  String emailText;
  AuthSendEmailEvent(this.emailText);
}
