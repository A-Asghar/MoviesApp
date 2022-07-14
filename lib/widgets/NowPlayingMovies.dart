import 'package:flutter/material.dart';

import '../screens/DetailsScreen.dart';

Widget NowPlayingMovies(nowPlayingMoviesList, imageUrl) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: nowPlayingMoviesList.length,
    itemBuilder: (BuildContext context, int index) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailsScreen(movie: nowPlayingMoviesList[index])));
      },
      child: Container(
        padding: EdgeInsets.only(left: 15, bottom: 20),
        child: Image(
          image: NetworkImage(
              '$imageUrl${nowPlayingMoviesList[index]['poster_path']}'),
        ),
      ),
    ),
  );
}
