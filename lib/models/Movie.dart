class Movie {
  int id;
  String name;
  String poster_path;
  String overview;
  double vote_average;

  Movie(
      {required this.id,
      required this.name,
      required this.poster_path,
      required this.overview,
      required this.vote_average});
}
