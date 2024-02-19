import 'package:flutter/material.dart';
import 'package:quiz_app/components/result_summary.dart';
import 'package:quiz_app/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.summary,
    required this.onTapStartQuiz,
  });

  final List<Map<String, Object>> summary;

  final void Function() onTapStartQuiz;

  @override
  Widget build(BuildContext context) {
    final numberOfTotalQuestions = questions.length;
    var numberOfCorrectAnswers = summary.where((data) {
      return data['correct_answer'] == data['chosen_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have correctly answered $numberOfCorrectAnswers out of $numberOfTotalQuestions !',
              style: const TextStyle(color: Color.fromARGB(255, 234, 212, 249)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ResultSummary(summary: summary),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: onTapStartQuiz,
              child: const Row(children: [Text('Start Quiz')]),
            ),
          ],
        ),
      ),
    );
  }
}
