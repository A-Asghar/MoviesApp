import 'package:flutter/material.dart';

import '../screens/DetailsScreen.dart';

Widget TopRatedMovies(topRatedMoviesList, imageUrl) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: topRatedMoviesList.length,
    itemBuilder: (BuildContext context, int index) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailsScreen(movie: topRatedMoviesList[index])));
      },
      child: Container(
        padding: EdgeInsets.only(left: 15, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: NetworkImage(
                '$imageUrl${topRatedMoviesList[index]['poster_path']}'),
          ),
        ),
      ),
    ),
  );
}
