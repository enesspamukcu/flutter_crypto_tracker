
import 'package:flutter/material.dart';

class RichTextt extends StatelessWidget {
  RichTextt({
    required this.text,
    required this.textStyle2,
    required this.text2,
    required this.textStyle1,
  });
  String text;
  TextStyle textStyle2;
  TextStyle textStyle1;
  String text2;


  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: '$text : ', style: textStyle1, children: [
        TextSpan(
          text: ' $text2%',
          style: textStyle2,
        )
      ]),
    );
  }
}
