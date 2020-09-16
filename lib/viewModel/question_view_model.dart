import 'package:flutter/foundation.dart';
import 'package:life_in_the_uk/models/OptionStatus.dart';
import 'package:life_in_the_uk/models/Question.dart';

class QuestionViewModel {
  final Question question;
  var selectedAnswers = Set();
  bool showHint = false;
  bool isFavourite = false;

  QuestionViewModel(this.question);

  void toggleFavourite() {
    isFavourite = !isFavourite;
  }

  void toggleHint() {
    showHint = !showHint;
    print('hint toggled');
  }

  // update state when an option is selected
  void selected(int selectedAnswer) {
    selectedAnswers.add(selectedAnswer);
    if (question.answers.contains(selectedAnswer)) {
      options[selectedAnswer].updateStatus = OptionStatus.correct;
    } else {
      options[selectedAnswer].updateStatus = OptionStatus.incorrect;
    }
  }

  // check if this entire question has been answered correctly
  bool answeredCorrectly() {
    return setEquals(question.answers, selectedAnswers);
  }

  // Select an option at given index
  // if it is a correct answer, update the status to correct
  // if it is incorrect, update the status of the selected option to incorrect, enumerate all options highlighting the correct answers.
  void updateOptionStateAtIndex(int index) {
    if (!shouldAllowSelection()) {
      return;
    }
    selected(index);

    question.status = QuestionStatus.attempted;

    if (question.answers.contains(index)) {
      print('correct answer selected');
      question.options[index].updateStatus = OptionStatus.correct;

      if (question.answers.length > selectedAnswers.length) {
        question.status = QuestionStatus.incomplete;
      } else if (question.answers.length == selectedAnswers.length) {
        question.status = QuestionStatus.correct;
        print('all questions answered correctly');
      }
    } else {
      print('in-correct answer selected');
      question.options[index].updateStatus = OptionStatus.incorrect;

      for (int anAnswer in question.answers) {
        if (!selectedAnswers.contains(anAnswer)) {
          question.options[anAnswer].updateStatus = OptionStatus.correct;
        }
        print('auto setting up correct answer ${question.options[anAnswer].title}');
      }
    }
  }

  void resetOptionState() {
    for (int i = 0; options.length < i; i++) {
      options[i].updateStatus = OptionStatus.notSelected;
    }
  }

  // Only allow selection if the number of selected answers is lower than the available set answers for the question
  // Possible bug, if we have two answers, and we answer incorrectly on first trial, the use would still be able to tap the correct answer.
  bool shouldAllowSelection() {
    return question.status == QuestionStatus.notAttempted || question.status == QuestionStatus.incomplete;
  }

  get numberOfOptions => question.options.length;

  get title => question.title;

  get options => question.options;

  get hint => question.hint;

  get answers => question.answers;
}
