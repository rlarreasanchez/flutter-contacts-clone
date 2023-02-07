import 'package:hive/hive.dart';

class FavoritesDb {
  final favoritesBoxName = 'myFavorites';
  final favoritesDbName = 'favorites';
  Box<dynamic>? myFavoritesBox;
  List<String> favorites;

  FavoritesDb({this.favorites = const []}) {
    myFavoritesBox = Hive.box(favoritesBoxName);
    favorites = (myFavoritesBox != null)
        ? myFavoritesBox!.get(favoritesDbName) ?? []
        : [];
  }

  void addFavorite(String favoriteId) {
    favorites.add(favoriteId);
    favorites = favorites.toSet().toList();
    if (myFavoritesBox != null) {
      myFavoritesBox!.put(favoritesDbName, favorites);
    }
  }

  void removeFavorite(String favoriteId) {
    favorites = favorites.where((id) => id != (favoriteId)).toList();
    favorites = favorites.toSet().toList();
    if (myFavoritesBox != null) {
      myFavoritesBox!.put('favorites', favorites);
    }
  }
}
