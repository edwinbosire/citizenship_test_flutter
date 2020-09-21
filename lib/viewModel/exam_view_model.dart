import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:life_in_the_uk/models/Question.dart';
import 'package:life_in_the_uk/utilities/Data.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';

class ExamViewModel with ChangeNotifier {
  final List<QuestionViewModel> questionsViewModels;
  List<QuestionViewModel> attemptedQuestions = [];
  bool quizCompleted = false;
  int pageInFocus = 0;

  ExamViewModel(this.questionsViewModels) {
    this.attemptedQuestions.add(questionsViewModels[0]);
  }

  static ExamViewModel initWithTestData() {
    return ExamViewModel(questions.map((e) => QuestionViewModel(e)).toList());
  }

  int _currentQuestion = 0;

  int get totalQuestions {
    return questionsViewModels.length;
  }

  int get totalAttemptedQuestions => attemptedQuestions.length;

  int get currentQuestionIndex {
    return _currentQuestion;
  }

  set focus(int newValue) {
    pageInFocus = newValue;
    notifyListeners();
  }

  bool get showHint {
    return questionsViewModels[pageInFocus].showHint;
  }

  bool get isFavourite {
    return questionsViewModels[pageInFocus].isFavourite;
  }

  void toggleCurrentQuestionHint() {
    questionsViewModels[pageInFocus].toggleHint();
    notifyListeners();
  }

  void toggleCurrentQuestionFavourite() {
    questionsViewModels[pageInFocus].toggleFavourite();
    notifyListeners();
  }

  QuestionViewModel getCurrentQuestion() {
    return questionsViewModels[_currentQuestion];
  }

  // returns the next question
  QuestionViewModel getNextQuestion() {
    QuestionViewModel currentQuestionVM = getCurrentQuestion();
    if (_currentQuestion < questionsViewModels.length - 1 && !currentQuestionVM.shouldAllowSelection()) {
      _currentQuestion++;
      return questionsViewModels[_currentQuestion];
    } else {
      return null;
    }
  }

  double get score {
    int correct = 0;
    for (QuestionViewModel vm in questionsViewModels) {
      if (vm.question.status == QuestionStatus.correct) {
        correct++;
      }
    }
    return correct / questionsViewModels.length;
  }

  String resultPageDecision() => (score < 0.75) ? 'You have failed this quiz' : 'You have passed this quiz';
  String resultExplanation() => score < 0.75 ? 'The pass mrk required is 75%' : '';

  String get prompt => (getCurrentQuestion().answers.length == 2) ? 'Please choose TWO answers' : 'Please choose ONE answer';

  QuestionStatus updateCurrentQuestionWithSelection(int selection) {
    getCurrentQuestion().updateOptionStateAtIndex(selection);
    QuestionStatus currentStatus = getCurrentQuestion().questionStatus;
    QuestionViewModel nextQuestionViewModel = getNextQuestion();

    _appendAttemptedQuestions(nextQuestionViewModel);

    if (getCurrentQuestion().isAnswered == true && _isLastQuestion()) {
      Timer(Duration(seconds: 3), () {
        quizCompleted = true;
        notifyListeners();
      });
    } else {
      quizCompleted = false;
      notifyListeners();
    }

    return currentStatus;
  }

  bool _isLastQuestion() => _currentQuestion == questionsViewModels.length - 1;

  void _appendAttemptedQuestions(QuestionViewModel viewModel) {
    if (viewModel != null && !attemptedQuestions.contains(viewModel)) {
      attemptedQuestions.add(viewModel);
    }
  }

//  bool currentQuestionAnswer
  void showHintForCurrentQuestion() {
    getCurrentQuestion().showHint = true;
  }

  void resetExam() {
    quizCompleted = false;
    _currentQuestion = 0;
    attemptedQuestions = [questionsViewModels[0]];

    for (QuestionViewModel viewModel in questionsViewModels) {
      viewModel.reset();
    }

    notifyListeners();
  }
}
