import 'package:flutter/material.dart';
import 'package:imdb/screens/DetailsScreen.dart';

Widget SimilarMoviesList(repository, movie, imageUrl,similarMovies) {
  return SizedBox(
      height: 200,
      child: FutureBuilder(
        future: similarMovies,
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
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(movie: snapshot.data[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                            image: NetworkImage(imageUrl +
                                snapshot.data[index]['poster_path'])),
                      ),
                    ),
                  );
                });
          }
          return Text('Error ${snapshot.data}');
        },
      ));
}
