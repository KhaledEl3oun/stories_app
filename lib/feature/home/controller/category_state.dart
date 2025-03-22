part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadingMore extends CategoryState {} // ✅ عند تحميل المزيد

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  final List<StoryModel> stories;

  CategorySuccess(this.categories, this.stories);
}

class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}

class CategorySearchStateChanged extends CategoryState {
  final bool isSearchActive;

  CategorySearchStateChanged(this.isSearchActive);
}
