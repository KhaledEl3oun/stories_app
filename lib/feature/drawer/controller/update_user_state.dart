part of 'update_user_cubit.dart';

@immutable
sealed class UpdateUserState {}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserSucsses extends UpdateUserState {
  final UserUpdateModel updateUserModel;

  UpdateUserSucsses(this.updateUserModel);
}

final class UpdateUserFailure extends UpdateUserState {
  final String message;

  UpdateUserFailure(this.message);
}
