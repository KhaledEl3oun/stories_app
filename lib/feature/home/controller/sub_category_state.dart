part of 'sub_category_cubit.dart';

@immutable
sealed class SubCategoryState {}

final class SubCategoryInitial extends SubCategoryState {}

final class SubCategoryLoading extends SubCategoryState {}

final class SubCategorySuccess extends SubCategoryState {
  final List<SubCategoryModel> subCategories;
  SubCategorySuccess(this.subCategories);
}

final class SubCategoryFailure extends SubCategoryState {
  final String message;

  SubCategoryFailure(this.message);
}

/// ✅ **حالة جديدة لتحديث حالة البحث**
final class SearchStateChanged extends SubCategoryState {
  final bool isSearchActive;

  SearchStateChanged(this.isSearchActive);
}
