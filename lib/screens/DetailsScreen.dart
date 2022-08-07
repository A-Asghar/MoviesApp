import 'package:flutter/material.dart';
import 'package:imdb/providers/FavouritesProvider.dart';
import 'package:imdb/screens/Trailer.dart';
import 'package:imdb/widgets/HeadingText.dart';
import 'package:provider/provider.dart';

import '../repository.dart';
import '../widgets/DetailsPosterImage.dart';
import '../widgets/GenreList.dart';
import '../widgets/MovieRating.dart';
import '../widgets/SimilarMovies.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  final MoviesRepository repository = MoviesRepository();

  var similarMovies;
  var genres;
  var videoUrl;

  @override
  void initState() {
    similarMovies = repository.getSimilarMovies(widget.movie['id']);

    genres = repository.getGenreList(widget.movie['id']);

    videoUrl = repository.getVideoUrl(widget.movie['id']);

    // print(widget.movie['video'].toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1) Image
          DetailsPosterImage(widget.movie, imageUrl, context),

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
                              MovieRating(widget.movie),
                              AddToFavourite(
                                  context
                                          .watch<FavouritesProvider>()
                                          .favourites
                                          .contains(widget.movie['id'])
                                      ? Colors.red
                                      : Colors.grey, () {
                                context
                                    .read<FavouritesProvider>()
                                    .addToFavourites(widget.movie['id']);
                              })
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GenreList(genres),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const HeadingText(text: 'Storyline'),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Trailer(
                                          title: widget.movie['title'],
                                          videoUrl: videoUrl)));
                                },
                                child: const Chip(
                                    label: Text('Watch Trailer'),
                                    avatar: Icon(Icons.play_circle)),
                              )
                            ],
                          ),
                          MovieOverview(),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: HeadingText(text: 'Similar Movies'),
                          ),
                          SimilarMoviesList(repository, widget.movie, imageUrl,
                              similarMovies),
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
        widget.movie['title'],
        style: const TextStyle(fontSize: 25, fontFamily: 'Courier'),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget MovieOverview() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        widget.movie['overview'],
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
