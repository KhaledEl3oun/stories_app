import 'package:meta/meta.dart';
import '../model/user_model.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final UserModel user;
  AuthLoggedIn(this.user);
}

class AuthRegistered extends AuthState {
  final UserModel user;
  AuthRegistered(this.user);
}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class AuthGoogleSuccess extends AuthState {
  final String token;
  final String username;
  AuthGoogleSuccess(this.token, this.username);
}
