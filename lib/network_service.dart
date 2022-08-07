import 'package:imdb/main.dart';
import 'package:tmdb_api/tmdb_api.dart';

class NetworkService {
  global g = global();
  getPopularMovies() async {
    return g.tmdbWithCustomLogs.v3.trending
        .getTrending(mediaType: MediaType.movie);
  }

  getNowPlayingMovies() async {
    return await g.tmdbWithCustomLogs.v3.movies.getNowPlaying();
  }

  getGenreList(movieId) async {
    var result = await g.tmdbWithCustomLogs.v3.movies.getDetails(movieId);
    return result;
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

  getUpcomingMovies() async {
      return await g.tmdbWithCustomLogs.v3.movies.getUpcoming();
  }

  getVideoUrl(movieId) async{
    return await g.tmdbWithCustomLogs.v3.movies.getVideos(movieId);
  }
}
