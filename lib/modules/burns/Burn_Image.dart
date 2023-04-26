import 'dart:io';
import 'package:flutter/material.dart';

class BurnImage extends StatelessWidget {
  File? image;
  BurnImage(image)
  {
    this.image=image;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Image.file(image!,)
      ,);
  }
}
