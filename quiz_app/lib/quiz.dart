import 'package:flutter/material.dart';

import 'package:quiz_app/questions_screen.dart';
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
}

class _QuizState extends State<Quiz> {
  ScreenType? activeScreen;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 50, 4, 58),
              Color.fromARGB(255, 130, 7, 152)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: activeScreen == ScreenType.questionScreen
              ? const QuestionScreen()
              : WelcomePage(switchScreen),
        ),
      ),
    );
  }
}
