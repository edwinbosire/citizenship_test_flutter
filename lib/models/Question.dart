import 'package:life_in_the_uk/models/OptionStatus.dart';

import 'Option.dart';

enum QuestionStatus { attempted, notAttempted, correct, incorrect, incomplete }

class Question {
  final String title;
  final String hint;
  final List<Option> options;
  final Set<int> answers;
  QuestionStatus status = QuestionStatus.notAttempted;
  Question({this.title, this.hint, this.options, this.answers});

  void resetStatus() {
    status = QuestionStatus.notAttempted;

    for (Option option in options) {
      option.status = OptionStatus.notSelected;
    }
  }
}
