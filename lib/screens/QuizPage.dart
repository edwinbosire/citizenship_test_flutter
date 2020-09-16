import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_in_the_uk/utilities/Data.dart';
import 'package:life_in_the_uk/viewModel/exam_view_model.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';
import 'package:life_in_the_uk/widgets/ExplanationTile.dart';
import 'package:life_in_the_uk/widgets/NavigationBarButton.dart';

import '../widgets/OptionListTile.dart';
import '../widgets/QuestionHeader.dart';
import 'ResultsPage.dart';

class QuizPage extends StatefulWidget {
  final ExamViewModel examViewModel = ExamViewModel(questions.map((e) => QuestionViewModel(e)).toList());

//  const QuizPage({Key key, this.examViewModel}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController _pageController;
  ScrollController _scrollController;
  List<QuestionViewModel> attemptedQuestions = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
    QuestionViewModel questionViewModel = widget.examViewModel.getCurrentQuestion();
    attemptedQuestions.add(questionViewModel);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollToNextPage(int currentIndex, QuestionViewModel currentQuestionViewModel) {
    setState(() {
      currentQuestionViewModel.updateOptionStateAtIndex(currentIndex);
      QuestionViewModel nextQuestionViewModel = widget.examViewModel.getNextQuestion();

      if (nextQuestionViewModel != null && !attemptedQuestions.contains(nextQuestionViewModel)) {
        attemptedQuestions.add(nextQuestionViewModel);

        if (_pageController.hasClients && currentQuestionViewModel.answeredCorrectly()) {
          Timer(Duration(seconds: 1), () {
            _pageController.animateToPage(
              widget.examViewModel.currentQuestionIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        } else {
          // if incorrect, don't navigate to next page, show hint instead
          currentQuestionViewModel.showHint = true;
          _scrollToBottom();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.examViewModel.quizCompleted()
        ? ResultsPage(viewModel: widget.examViewModel)
        : Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.times,
                    size: 22,
                  ),
                ),
              ),
              title: Center(
                child: Text(
                  "24:00",
                  style: TextStyle(fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              actions: [
                Row(
                  children: <Widget>[
                    NavigationBarButtonItem(
                      selected: widget.examViewModel.isFavourite,
                      normalStateIcon: FontAwesomeIcons.star,
                      selectedStateIcon: FontAwesomeIcons.solidStar,
                      onTap: () {
                        setState(() {
                          widget.examViewModel.toggleCurrentQuestionFavourite();
                        });
                      },
                    ),
                    NavigationBarButtonItem(
                      selected: widget.examViewModel.showHint,
                      normalStateIcon: FontAwesomeIcons.lightbulb,
                      selectedStateIcon: FontAwesomeIcons.solidLightbulb,
                      onTap: () {
                        setState(() {
                          widget.examViewModel.toggleCurrentQuestionHint();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            backgroundColor: Colors.grey[200],
            body: PageView.builder(
              itemCount: attemptedQuestions.length,
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (BuildContext context, int pageIndex) {
                QuestionViewModel questionVM = attemptedQuestions[pageIndex];
                return QuizCard(
                  scrollController: _scrollController,
                  totalNumberOfQuestions: widget.examViewModel.totalQuestions,
                  questionViewModel: questionVM,
                  pageIndex: pageIndex,
                  showHint: widget.examViewModel.showHint,
                  onOptionSelection: (ndx, q) => _scrollToNextPage(ndx, q),
                );
              },
            ),
          );
  }
}

class QuizCard extends StatelessWidget {
  final ScrollController scrollController;
  final int totalNumberOfQuestions;
  final QuestionViewModel questionViewModel;
  final int pageIndex;
  final bool showHint;
  final Function onOptionSelection;

  const QuizCard({Key key, this.scrollController, this.totalNumberOfQuestions, this.questionViewModel, this.pageIndex, this.showHint, this.onOptionSelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.only(bottom: 25.0),
            itemCount: (questionViewModel.numberOfOptions + 2), // Two divider top and bottom
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              indent: (index == 0 || index == questionViewModel.numberOfOptions) ? 0 : 20,
              height: 0,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    QuestionHeader(
                      question: questionViewModel,
                      index: pageIndex + 1,
                      totalQuestions: totalNumberOfQuestions,
                    ),
                    SizedBox(height: 120),
                  ],
                );
              } else if (index == questionViewModel.numberOfOptions + 1) {
                return ExplanationTile(showHint: questionViewModel.showHint, questionViewModel: questionViewModel);
              } else {
                return OptionsListTile(
                  title: questionViewModel.options[index - 1].title,
                  status: questionViewModel.options[index - 1].status,
                  onTap: () => {
                    if (questionViewModel.shouldAllowSelection()) {onOptionSelection(index - 1, questionViewModel)}
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
