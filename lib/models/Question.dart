import 'Option.dart';

enum QuestionStatus { attempted, notAttempted, correct, incorrect, incomplete }

class Question {
  final String title;
  final String hint;
  final List<Option> options;
  final Set<int> answers;
  QuestionStatus status = QuestionStatus.notAttempted;
  Question({this.title, this.hint, this.options, this.answers});
}
