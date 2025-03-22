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

<<<<<<< HEAD
class AuthUpdated extends AuthState {
  final UserModel user;
  AuthUpdated(this.user);
}


class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
=======
class AuthGoogleSuccess extends AuthState {
  final String token;
  final String username;
  AuthGoogleSuccess(this.token, this.username);
>>>>>>> 9ae9e37eeb2f6a027fb6735e992c6cb6be7ed202
}
