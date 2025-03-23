part of 'sub_category_cubit.dart';

@immutable
abstract class SubCategoryState {}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategorySuccess extends SubCategoryState {
  final List<SubCategoryModel> subCategories;
  SubCategorySuccess(this.subCategories);
}

class SubCategoryFailure extends SubCategoryState {
  final String message;
  SubCategoryFailure(this.message);
}

class SearchStateChanged extends SubCategoryState {
  final bool isSearchActive;
  SearchStateChanged(this.isSearchActive);
}
