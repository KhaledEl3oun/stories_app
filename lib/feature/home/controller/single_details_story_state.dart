part of 'single_details_story_cubit.dart';

@immutable
sealed class DetailsStoryState {}

final class SingleDetailsCategoryInitial extends DetailsStoryState {}

final class DetailsStoryLoading extends DetailsStoryState {}

final class DetailsStorySuccess extends DetailsStoryState {
  final SingleStoryModel singleCategory;
  DetailsStorySuccess(this.singleCategory);
}

final class DetailsStoryFailure extends DetailsStoryState {
  final String message;
  DetailsStoryFailure(this.message);
}
