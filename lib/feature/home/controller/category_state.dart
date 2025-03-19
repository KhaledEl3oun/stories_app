part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  final List<StoryModel> stories;

  CategorySuccess(this.categories, this.stories);
}

final class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}

/// ✅ **حالة جديدة لتحديث حالة البحث**
final class CategorySearchStateChanged extends CategoryState {
  final bool isSearchActive;

  CategorySearchStateChanged(this.isSearchActive);
}
