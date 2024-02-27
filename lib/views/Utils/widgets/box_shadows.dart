import 'package:flutter/material.dart';

class AppShadows {
  static List<BoxShadow> blackThemeShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.5), // Outside box shadow color
      spreadRadius: 3,
      blurRadius: 10,
      offset: const Offset(3, 3),
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.2), // Outside box shadow color
      spreadRadius: 3,
      blurRadius: 10,
      offset: const Offset(-3, 0),
    ),
  ];

// ^ Light Theme shadow
  static List<BoxShadow> lightThemeShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Outside box shadow color
      spreadRadius: 3,
      blurRadius: 10,
      offset: const Offset(3, 3),
    ),
    BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Outside box shadow color
      spreadRadius: 3,
      blurRadius: 10,
      offset: const Offset(-3, 0),
    ),
  ];
}
