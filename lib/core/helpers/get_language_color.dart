import 'package:flutter/material.dart';

Color getColorForLanguage(String? language) {
  switch (language?.toLowerCase()) {
    case 'javascript':
      return Colors.amber;
    case 'typescript':
      return Colors.blue;
    case 'python':
      return Colors.green;
    case 'java':
      return Colors.red;
    case 'c#':
      return Colors.teal;
    case 'c++':
      return Colors.pink;
    case 'go':
      return Colors.cyan;
    case 'rust':
      return Colors.deepOrange;
    case 'php':
      return Colors.purple;
    case 'ruby':
      return Colors.red;
    case 'dart':
      return Colors.lightBlue;
    case 'html':
      return Colors.orange;
    case 'css':
      return Colors.indigo;
    case 'kotlin':
      return Colors.amber.shade800;
    case 'swift':
      return Colors.orange.shade700;

    default:
      return Colors.blue;
  }
}
