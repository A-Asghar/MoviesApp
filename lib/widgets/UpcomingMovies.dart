import 'package:flutter/material.dart';

import '../screens/DetailsScreen.dart';

Widget UpcomingMovies(upcomingMoviesList, imageUrl) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: upcomingMoviesList.length,
    itemBuilder: (BuildContext context, int index) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailsScreen(movie: upcomingMoviesList[index])));
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.only(left: 15, bottom: 20),
        child: Image(
          image: NetworkImage(
              '$imageUrl${upcomingMoviesList[index]['poster_path']}'),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
