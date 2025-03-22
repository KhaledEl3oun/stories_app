part of 'reed_un_reed_story_cubit.dart';

@immutable
sealed class ReedUnReedStoryState {}

final class ReedUnReedStoryInitial extends ReedUnReedStoryState {}

final class ReedUnReedStoryLoading extends ReedUnReedStoryState {}

final class ReedUnReedStorySuccess extends ReedUnReedStoryState {
  final ReedUnReedStoryModel response;

  ReedUnReedStorySuccess(this.response);
}

final class ReedUnReedStoryFailure extends ReedUnReedStoryState {
  final String error;

  ReedUnReedStoryFailure(this.error);
}
