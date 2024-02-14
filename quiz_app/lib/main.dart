import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/welcome_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Quiz(),
      ),
    ),
  );
}
