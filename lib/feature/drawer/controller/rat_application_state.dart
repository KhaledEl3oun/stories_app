part of 'rat_application_cubit.dart';

@immutable
sealed class RatApplicationState {}

final class RatApplicationInitial extends RatApplicationState {}

final class RatApplicationLoading extends RatApplicationState {}

final class RatApplicationSucsses extends RatApplicationState {
  final ReviewModel reviewModel;

  RatApplicationSucsses(this.reviewModel);
}

final class RatApplicationFailure extends RatApplicationState {
  final String message;

  RatApplicationFailure(this.message);
}
