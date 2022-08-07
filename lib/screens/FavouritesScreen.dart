import 'package:flutter/material.dart';
import 'package:imdb/providers/FavouritesProvider.dart';
import 'package:imdb/widgets/HeadingText.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Movie.dart';
import '../repository.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Movie> favourites = [];
  MoviesRepository repository = MoviesRepository();
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (favourites.isEmpty) {
      getFavouriteMovies();
    }
  }

  getFavouriteMovies() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? items = prefs.getStringList('items');
    if (items != null) {
      context.read<FavouritesProvider>().favourites =
          items.map(int.parse).toList();
    }

    favourites = await repository
        .getFavouriteMovies(context.read<FavouritesProvider>().favourites);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const HeadingText(text: 'Favourites'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: FavouriteMovieTile(favourites[index]),
            );
          }),
    ));
  }

  Widget FavouriteMovieTile(Movie movie) {
    return Row(
      children: [
        SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Image(image: NetworkImage(imageUrl + movie.poster_path)),
        ),
        SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.68,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Courier',
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.68,
                child: Text(
                  movie.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              MovieRating(movie)
            ],
          ),
        )
      ],
    );
  }

  Widget MovieRating(movie) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.amberAccent,
          ),
          const Icon(
            Icons.star,
            color: Colors.amberAccent,
          ),
          const Icon(
            Icons.star,
            color: Colors.amberAccent,
          ),
          const Icon(
            Icons.star,
            color: Colors.amberAccent,
          ),
          const Icon(
            Icons.star_half,
            color: Colors.amberAccent,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            movie.vote_average.toStringAsFixed(1),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
