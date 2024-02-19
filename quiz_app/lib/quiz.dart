import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/welcome_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

enum ScreenType {
  welcomeScreen,
  questionScreen,
  resultScreen,
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  ScreenType activeScreen = ScreenType.welcomeScreen;

  @override
  void initState() {
    activeScreen = ScreenType.welcomeScreen;
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = ScreenType.questionScreen;
    });
  }

  List<Map<String, Object>> getSummary() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'chosen_answer': selectedAnswers[i],
      });
    }

    return summary;
  }

  void setAnswers(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ScreenType.resultScreen;
      });
    }
  }

  void startQuiz() {
    setState(() {
      activeScreen = ScreenType.welcomeScreen;
      selectedAnswers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreenWidget = WelcomePage(switchScreen);
    if (activeScreen == ScreenType.questionScreen) {
      activeScreenWidget = QuestionScreen(onSelectAnswer: setAnswers);
    }

    if (activeScreen == ScreenType.resultScreen) {
      activeScreenWidget = ResultScreen(
        summary: getSummary(),
        onTapStartQuiz: startQuiz,
      );
    }

    // switch (activeScreen) {
    //   case ScreenType.welcomeScreen:
    //     activeScreenWidget = WelcomePage(switchScreen);
    //     break;
    //   case ScreenType.questionScreen:
    //     activeScreenWidget = QuestionScreen(onSelectAnswer: setAnswers);
    //     break;
    //   case ScreenType.resultScreen:
    //     activeScreenWidget = const ResultScreen();
    //     print('resultScreen');
    //     break;
    // }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 50, 4, 58),
              Color.fromARGB(255, 130, 7, 152)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: activeScreenWidget,
        ),
      ),
    );
  }
}
