import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  const AnswerButton(this.answer, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple, foregroundColor: Colors.white),
      child: Text(answer),
    );
  }
}
