import 'package:flutter/foundation.dart';
import 'package:life_in_the_uk/models/Question.dart';
import 'package:life_in_the_uk/utilities/Data.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';

class ExamViewModel with ChangeNotifier {
  final List<QuestionViewModel> questionsViewModels;
  List<QuestionViewModel> attemptedQuestions = [];

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

  int get currentQuestionIndex {
    return _currentQuestion;
  }

  bool get showHint {
    return getCurrentQuestion().showHint;
  }

  bool get isFavourite {
    return getCurrentQuestion().isFavourite;
  }

  void toggleCurrentQuestionFavourite() {
    getCurrentQuestion().toggleFavourite();
  }

  void toggleCurrentQuestionHint() {
    getCurrentQuestion().toggleHint();
  }

  QuestionViewModel getCurrentQuestion() {
    return questionsViewModels[_currentQuestion];
  }

  bool quizCompleted() {
    bool incomplete = questionsViewModels
            .where((viewModel) => (viewModel.question.status == QuestionStatus.incomplete || viewModel.question.status == QuestionStatus.notAttempted))
            .length >
        0;
    return !incomplete;
  }

  // returns the next question
  QuestionViewModel getNextQuestion() {
    QuestionViewModel currentQuestionVM = getCurrentQuestion();
    if (_currentQuestion < questionsViewModels.length - 1 && !currentQuestionVM.shouldAllowSelection()) {
      print('next question requested');
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

  QuestionStatus updateCurrentQuestionWithSelection(int selection) {
    getCurrentQuestion().updateOptionStateAtIndex(selection);
    QuestionStatus currentStatus = getCurrentQuestion().questionStatus;
    QuestionViewModel nextQuestionViewModel = getNextQuestion();

    _appendAttemptedQuestions(nextQuestionViewModel);

    notifyListeners();

    return currentStatus;
  }

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
    print('reset exam called');
    _currentQuestion = 0;
    attemptedQuestions = [questionsViewModels[0]];

    for (QuestionViewModel viewModel in questionsViewModels) {
      viewModel.reset();
    }

    notifyListeners();
  }
}
