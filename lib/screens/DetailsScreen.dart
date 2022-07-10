import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imdb/providers/FavouritesProvider.dart';
import 'package:imdb/widgets/HeadingText.dart';
import 'package:provider/provider.dart';

import '../repository.dart';

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
          SizedBox(
            child: Align(
              alignment: Alignment.topCenter,
              child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.black.withOpacity(0)],
                          stops: [0.6, 0.7]).createShader(rect);
                    },
                    blendMode: BlendMode.dstATop,
                    child: Image.network(imageUrl + movie['poster_path'],
                        fit: BoxFit.cover, alignment: Alignment.bottomCenter),
                  )),
            ),
          ),

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
                              MovieRating(),
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
                          GenreList(movie['genre_ids']),
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
                          SimilarMoviesList(),
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

  Widget SimilarMoviesList() {
    return SizedBox(
        height: 200,
        child: FutureBuilder(
          future: repository.getSimilarMovies(movie['id']),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                            image: NetworkImage(imageUrl +
                                snapshot.data[index]['poster_path'])),
                      ),
                    );
                  });
            }
            return Text('Error ${snapshot.data}');
          },
        ));
  }

  Widget GenreList(genre_ids) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: genre_ids.length,
          itemBuilder: (context, index) {
            return Container(
              // height: 60,
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.withOpacity(0.8)),
              child: FutureBuilder(
                  future: repository.getGenreList(genre_ids[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(snapshot.data.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            );
          }),
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

  Widget MovieRating() {
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
            movie['vote_average'].toStringAsFixed(1),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
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
