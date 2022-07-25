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

  getGenreList(int movieId) async {
    var response = await networkService.getGenreList(movieId);
    List<String> genres = [];
    var x = response['genres'];

    for (var v in x) {
      genres.add(v['name']);
    }
    return genres;
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

  getUpcomingMovies() async {
    var response = await networkService.getUpcomingMovies();
    return response['results'].toList();
  }

  getVideoUrl(movieId) async {
    var response = await networkService.getVideoUrl(movieId);
    // print(response['results'][0]['key'].toString());
    return response['results'][0]['key'];
  }
}
