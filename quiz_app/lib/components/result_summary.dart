import 'package:flutter/material.dart';

class ResultSummary extends StatelessWidget {
  const ResultSummary({super.key, required this.summary});

  final List<Map<String, Object>> summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: summary.map((data) {
        return Row(
          children: [
            Text(
              ((data['question_index'] as int) + 1).toString(),
              style: const TextStyle(color: Colors.white),
            ),
            Expanded(
              // Expanded:  the child columns will not take more than it's parent widget Row
              child: Column(
                children: [
                  Text(data['question'] as String,
                      style: const TextStyle(color: Colors.white)),
                  Text(data['correct_answer'] as String,
                      style: const TextStyle(color: Colors.white)),
                  Text(data['chosen_answer'] as String,
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
