import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  const MyText(this.text,{Key? key, this.size, this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
