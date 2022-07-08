import 'package:flutter/material.dart';

class Historique extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}
