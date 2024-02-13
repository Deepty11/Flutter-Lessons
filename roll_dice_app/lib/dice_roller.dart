import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var number = 2;
  final random = Random();

  void onPressed() {
    setState(() {
      number = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$number.png',
          width: 200,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            foregroundColor: Colors.red,
            padding: const EdgeInsets.all(10),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
