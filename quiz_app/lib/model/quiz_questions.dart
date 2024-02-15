class QuizModel {
  const QuizModel(this.text, this.answers);

  final String text;
  final List<String> answers;

// method to get shuffled list,
// so that it does not update the main list
  List<String> getShuffledAnswers() {
    var shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
