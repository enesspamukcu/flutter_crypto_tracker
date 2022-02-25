import 'package:flutter/material.dart';

import '../constants.dart';

class LinkButton extends StatelessWidget {
  LinkButton({required this.text, required this.onPress});
  String text;
  Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(),
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 8),
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: Constants.coinDetailText,
        ),
        decoration: BoxDecoration(
            color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
