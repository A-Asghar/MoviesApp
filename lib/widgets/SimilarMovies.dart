import 'package:flutter/material.dart';

Widget SimilarMoviesList(repository, movie, imageUrl) {
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
                          image: NetworkImage(
                              imageUrl + snapshot.data[index]['poster_path'])),
                    ),
                  );
                });
          }
          return Text('Error ${snapshot.data}');
        },
      ));
}
