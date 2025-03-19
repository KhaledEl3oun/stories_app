part of 'single_details_category_cubit.dart';

@immutable
sealed class SingleDetailsCategoryState {}

final class SingleDetailsCategoryInitial extends SingleDetailsCategoryState {}

final class SingleDetailsCategoryLoading extends SingleDetailsCategoryState {}

final class SingleDetailsCategorySuccess extends SingleDetailsCategoryState {
  final SingleCategoryModel singleCategory;
  SingleDetailsCategorySuccess(this.singleCategory);
}

final class SingleDetailsCategoryFailure extends SingleDetailsCategoryState {
  final String message;
  SingleDetailsCategoryFailure(this.message);
}
