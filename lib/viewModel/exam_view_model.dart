import 'package:life_in_the_uk/models/Question.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';

class ExamViewModel {
  final List<QuestionViewModel> questionsViewModels;
  ExamViewModel(this.questionsViewModels);

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
    print('Check if quiz is completed');
    print('Current Question $_currentQuestion');
//    QuestionViewModel currentQuestionVM = getCurrentQuestion();
//    if (_currentQuestion != questionsViewModels.length - 1 || currentQuestionVM.shouldAllowSelection()) {
//      return false;
//    }

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
}
