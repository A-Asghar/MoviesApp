import 'dart:ui';

import 'package:flutter/material.dart';

Widget DetailsPosterImage(movie, imageUrl) {
  return SizedBox(
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
  );
}
