import 'package:flutter/material.dart';

class MegaText extends StatelessWidget {
  const MegaText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Courier',
            fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
