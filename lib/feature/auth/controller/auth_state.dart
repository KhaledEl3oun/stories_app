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

class AuthUpdated extends AuthState {
  final UserModel user;
  AuthUpdated(this.user);
}


class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
