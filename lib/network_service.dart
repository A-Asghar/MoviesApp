import 'package:tmdb_api/tmdb_api.dart';

import 'package:imdb/main.dart';

class NetworkService {
  global g = global();
  getPopularMovies() async {
    // print(await g.tmdbWithCustomLogs.v3.trending.getTrending());
    return g.tmdbWithCustomLogs.v3.trending
        .getTrending(mediaType: MediaType.movie);
  }

  getNowPlayingMovies() async{
    return await g.tmdbWithCustomLogs.v3.movies.getNowPlaying();
  }

  getGenreList() async{
    return await g.tmdbWithCustomLogs.v3.genres.getMovieList();
  }

  getTopRatedMovies() async{
    return await g.tmdbWithCustomLogs.v3.movies.getTopRated();
  }

  getSimilarMovies(movieId) async{
    // print(await g.tmdbWithCustomLogs.v3.movies.getSimilar(movieId) );
    return await g.tmdbWithCustomLogs.v3.movies.getSimilar(movieId);
  }

}
