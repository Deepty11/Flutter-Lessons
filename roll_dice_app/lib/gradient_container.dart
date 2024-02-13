import 'package:flutter/material.dart';
import 'package:roll_dice_app/dice_roller.dart';

const startAlignment = Alignment.bottomCenter;
const endAlignment = Alignment.topCenter;

class GradientContainer extends StatelessWidget {
  final List<Color> colors;

  const GradientContainer({super.key, required this.colors});

  GradientContainer.colors({super.key})
      : colors = [
          Colors.black,
          Colors.white,
        ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: const Center(child: DiceRoller()),
    );
  }
}
