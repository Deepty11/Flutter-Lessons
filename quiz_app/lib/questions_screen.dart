import 'package:flutter/material.dart';
import 'package:quiz_app/components/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      // SizeBox is alternate approach of Center widget
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .center, // if use SizeBox, need to specify maxAxisAlignment
        children: [
          Text(
            'question ...',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          SizedBox(height: 20),
          AnswerButton('Answer 1'),
          AnswerButton('Answer 2'),
          AnswerButton('Answer 3'),
          AnswerButton('Answer 4'),
        ],
      ),
    );
  }
}
