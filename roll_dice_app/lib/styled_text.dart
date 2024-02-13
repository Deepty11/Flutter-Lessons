import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  // declariing it final, which means that it will only be updated through constructor, but not internally
  final String outputText;
  const StyledText(this.outputText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      outputText,
      style: const TextStyle(
          fontSize: 22.0,
          backgroundColor: Colors.deepPurple,
          fontWeight: FontWeight.bold),
    );
  }
}
