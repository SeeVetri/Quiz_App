// lib/models/question.dart
class Question {
  final String text;
  final String quranText;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.text,
    required this.quranText,
    required this.options,
    required this.correctOptionIndex,
  });
}
