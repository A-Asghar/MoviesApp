import 'package:imdb/network_service.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'models/Movie.dart';

class MoviesRepository {
  NetworkService networkService = NetworkService();
  getPopularMovies() async {
    var response = await networkService.getPopularMovies();
    // print('Response ' + response['results'][0]['title']);
    return response['results'].toList();
  }

  getNowPlayingMovies() async {
    var response = await networkService.getNowPlayingMovies();
    // print('Response 2'  + response['results'][0]['title']);
    return response['results'].toList();
  }

  Future<String> getGenreList(int genre_id) async {
    var response = await networkService.getGenreList();
    // print('Genre ID ' + genre_id.toString());
    String genre = '';
    response['genres'].forEach((element) {
      if (element['id'] == genre_id) {
        // print(element['name']);
        // return element['name'].toString();
        genre = element['name'];
      }
    });
    return genre;
  }

  getTopRatedMovies() async {
    var response = await networkService.getTopRatedMovies();
    return response['results'].toList();
  }

  getSimilarMovies(movieId) async {
    var response = await networkService.getSimilarMovies(movieId);
    // print('Response > '  + response['results'][0]['title']);
    return response['results'].toList();
  }

  getFavouriteMovies(List<int> movieIds) async {
    var response = await networkService.getMoviesById(movieIds);
    // var result = Map();
    List<Movie> favourites = [];
    response.forEach((movie) {
      favourites.add(Movie(
          id: movie['id'],
          name: movie['title'],
          poster_path: movie['poster_path'],
          vote_average: movie['vote_average'],
          overview: movie['overview']));
    });
    return favourites;
    // print('Response > $response');
  }
}
