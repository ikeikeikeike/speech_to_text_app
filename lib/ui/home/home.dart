import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeStyle extends TextStyle {
  const HomeStyle({
    double fontSize = 12.0,
    FontWeight fontWeight,
    Color color = Colors.black87,
    double letterSpacing,
    double height,
  }) : super(
          inherit: false,
          color: color,
          fontFamily: 'Raleway',
          fontSize: fontSize,
          fontWeight: fontWeight,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: letterSpacing,
          height: height,
        );
}

class HomePage {
  const HomePage({
    this.icon,
    this.text,
    this.imagePath,
    this.imagePackage,
  });
  final IconData icon;
  final String text;
  final String imagePath;
  final String imagePackage;
}
