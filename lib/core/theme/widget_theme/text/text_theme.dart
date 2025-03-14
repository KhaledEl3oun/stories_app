import 'package:flutter/material.dart';

class TextThemes {
  static const TextTheme light = TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 20),
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
    bodySmall: TextStyle(color: Colors.black54, fontSize: 14),
  );

  static const TextTheme dark = TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
    bodySmall: TextStyle(color: Colors.white, fontSize: 14),
  );
}
