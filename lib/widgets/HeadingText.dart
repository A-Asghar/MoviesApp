import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
