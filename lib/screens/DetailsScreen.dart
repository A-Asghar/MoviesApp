import 'package:flutter/material.dart';
import 'package:imdb/providers/FavouritesProvider.dart';
import 'package:imdb/widgets/HeadingText.dart';
import 'package:provider/provider.dart';

import '../repository.dart';
import '../widgets/DetailsPosterImage.dart';
import '../widgets/GenreList.dart';
import '../widgets/MovieRating.dart';
import '../widgets/SimilarMovies.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final movie;
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';
  final MoviesRepository repository = MoviesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1) Image
          DetailsPosterImage(movie, imageUrl),

          // 2) Container
          Positioned(
              bottom: 0,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MovieTitle(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MovieRating(movie),
                              AddToFavourite(
                                  context
                                          .watch<FavouritesProvider>()
                                          .favourites
                                          .contains(movie['id'])
                                      ? Colors.red
                                      : Colors.grey, () {
                                context
                                    .read<FavouritesProvider>()
                                    .addToFavourites(movie['id']);
                              })
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GenreList(movie['genre_ids'], repository),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: HeadingText(text: 'Storyline'),
                          ),
                          MovieOverview(),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: HeadingText(text: 'Similar Movies'),
                          ),
                          SimilarMoviesList(repository, movie, imageUrl),
                        ],
                      ),
                    ),
                  ))),

          // 3) Back Button
          Positioned(
            top: 45,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50)),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white.withOpacity(0.6),
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget MovieTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        movie['title'],
        style: const TextStyle(fontSize: 25, fontFamily: 'Courier'),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget MovieOverview() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        movie['overview'],
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget AddToFavourite(color, VoidCallback onPressed) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.favorite,
          color: color,
          size: 30,
        ));
  }
}
