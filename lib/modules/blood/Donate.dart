import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Text(
        "Donate",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    );
  }
}
