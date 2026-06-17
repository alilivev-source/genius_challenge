class QuestionModel {
  final String question;
  final List<String> answers;
  final int correctIndex;
  final String hint;

  QuestionModel({
    required this.question,
    required this.answers,
    required this.correctIndex,
    required this.hint,
  });
}