import 'package:flutter/material.dart';

Widget GenreList(genre_ids, repository) {
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
