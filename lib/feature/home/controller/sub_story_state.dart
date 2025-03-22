part of 'sub_story_cubit.dart';

@immutable
sealed class SubStoryState {}

final class SubStoryInitial extends SubStoryState {}

final class SubStoryLoading extends SubStoryState {}

final class SubStorySuccess extends SubStoryState {
  final List<SubStoryModel> subStoryModel;

  SubStorySuccess(this.subStoryModel);
}

final class SubStoryFailure extends SubStoryState {
  final String message;

  SubStoryFailure(this.message);
}

final class SearchStateChanged extends SubStoryState {
  final bool isSearchActive;

  SearchStateChanged(this.isSearchActive);
}
