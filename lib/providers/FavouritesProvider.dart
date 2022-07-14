import 'package:flutter/material.dart';

class FavouritesProvider extends ChangeNotifier {
  List<int> _favourites = [];

  List<int> get favourites => _favourites;

  set favourites(favourites) {
    _favourites = favourites;
  }

  addToFavourites(int movieId) {
    if (_favourites.contains(movieId)) {
      _favourites.remove(movieId);
    } else {
      _favourites.add(movieId);
    }
    notifyListeners();
  }
}
