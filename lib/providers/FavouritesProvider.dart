import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider extends ChangeNotifier {
  List<int> _favourites = [];

  List<int> get favourites => _favourites;

  set favourites(favourites) {
    _favourites = favourites;
  }

  addToFavourites(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favourites.contains(movieId)) {
      _favourites.remove(movieId);
    } else {
      _favourites.add(movieId);
    }
    await prefs.remove('items');
    prefs.setStringList('items', _favourites.map((e) => e.toString()).toList());
    notifyListeners();
  }
}
