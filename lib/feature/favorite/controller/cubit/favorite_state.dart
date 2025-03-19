part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<GetAllFavoriteModel> getAllFavoriteModel;
  FavoriteSuccess(this.getAllFavoriteModel);
}

final class FavoriteFailure extends FavoriteState {
  final String message;

  FavoriteFailure(this.message);
}

final class AddFavoriteLoading extends FavoriteState {}

final class AddFavoriteSuccess extends FavoriteState {
  final AddFavoriteModel addFavoriteModel;
  AddFavoriteSuccess(this.addFavoriteModel);
}

final class AddFavoriteFailure extends FavoriteState {
  final String message;

  AddFavoriteFailure(this.message);
}

/// ✅ **حالة جديدة لتحديث حالة البحث**
final class SearchStateChanged extends FavoriteState {
  final bool isSearchActive;

  SearchStateChanged(this.isSearchActive);
}
