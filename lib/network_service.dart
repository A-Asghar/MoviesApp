import 'package:tmdb_api/tmdb_api.dart';

import 'package:imdb/main.dart';

class NetworkService {
  global g = global();
  getPopularMovies() async {
    return g.tmdbWithCustomLogs.v3.trending
        .getTrending(mediaType: MediaType.movie);
  }

  getNowPlayingMovies() async {
    return await g.tmdbWithCustomLogs.v3.movies.getNowPlaying();
  }

  getGenreList() async {
    return await g.tmdbWithCustomLogs.v3.genres.getMovieList();
  }

  getTopRatedMovies() async {
    return await g.tmdbWithCustomLogs.v3.movies.getTopRated();
  }

  getSimilarMovies(movieId) async {
    return await g.tmdbWithCustomLogs.v3.movies.getSimilar(movieId);
  }

  getMoviesById(List<int> movieIds) async {
    var movies = [];

    for (var m in movieIds) {
      movies.add(await g.tmdbWithCustomLogs.v3.movies.getDetails(m));
    }
    return movies;
  }
}
