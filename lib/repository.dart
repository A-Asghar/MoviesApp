import 'package:imdb/network_service.dart';

import 'models/Movie.dart';

class MoviesRepository {
  NetworkService networkService = NetworkService();
  getPopularMovies() async {
    var response = await networkService.getPopularMovies();
    return response['results'].toList();
  }

  getNowPlayingMovies() async {
    var response = await networkService.getNowPlayingMovies();
    return response['results'].toList();
  }

  Future<String> getGenreList(int genre_id) async {
    var response = await networkService.getGenreList();
    String genre = '';
    response['genres'].forEach((element) {
      if (element['id'] == genre_id) {
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
    return response['results'].toList();
  }

  getFavouriteMovies(List<int> movieIds) async {
    var response = await networkService.getMoviesById(movieIds);
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
  }
}
