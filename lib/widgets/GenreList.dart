import 'package:flutter/material.dart';

Widget GenreList(genres) {
  return FutureBuilder(
      future: genres,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SizedBox(
            height: 40,
            child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    child: Chip(
                        label: Text(
                      snapshot.data[index],
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                  );
                })),
          );
        }
        return const CircularProgressIndicator();
      });
}
