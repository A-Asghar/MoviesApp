import 'package:flutter/material.dart';
import 'package:imdb/repository.dart';

import '../models/Movie.dart';

class PopularMovies extends StatelessWidget {
  PopularMovies(){
    MoviesRepository repository = MoviesRepository();
    final List<Movie> moviesList = repository.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
