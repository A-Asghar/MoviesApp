import 'package:flutter/material.dart';

Widget MovieRating(movie) {
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
