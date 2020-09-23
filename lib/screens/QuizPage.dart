import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_in_the_uk/viewModel/exam_view_model.dart';
import 'package:life_in_the_uk/widgets/NavigationBarButton.dart';
import 'package:life_in_the_uk/widgets/quiz_card.dart';
import 'package:provider/provider.dart';

import 'ResultsPage.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Provider.of<ExamViewModel>(context, listen: false).startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamViewModel>(builder: (context, examViewModel, child) {
      return examViewModel.quizCompleted
          ? ResultsPage()
          : Scaffold(
              appBar: _buildAppBar(context),
              backgroundColor: Colors.grey[200],
              body: PageView.builder(
                itemCount: examViewModel.totalAttemptedQuestions,
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (BuildContext context, int pageIndex) {
                  return ChangeNotifierProvider.value(
                    value: examViewModel.questionsViewModels[pageIndex],
                    child: QuizCard(
                      onOptionSelection: () => _animateToPage(examViewModel.currentQuestionIndex),
                    ),
                  );
                },
                onPageChanged: (page) {
                  examViewModel.focus = page;
                },
              ),
            );
    });
  }

  void _animateToPage(int page) {
    Timer(Duration(seconds: 1), () {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[700],
      leading: GestureDetector(
        onTap: () {
          context.read<ExamViewModel>().resetExam();
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
          '${context.watch<ExamViewModel>().examDuration}',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontFeatures: [
              FontFeature.slashedZero(),
              FontFeature.tabularFigures(),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        _buildNavigationBarActionButtons(context),
      ],
    );
  }

  Row _buildNavigationBarActionButtons(BuildContext context) {
    ExamViewModel viewModel = Provider.of<ExamViewModel>(context);

    return Row(
      children: <Widget>[
        NavigationBarButtonItem(
          selected: viewModel.isFavourite,
          normalStateIcon: FontAwesomeIcons.star,
          selectedStateIcon: FontAwesomeIcons.solidStar,
          onTap: () => viewModel.toggleCurrentQuestionFavourite(),
        ),
        NavigationBarButtonItem(
          selected: viewModel.showHint,
          normalStateIcon: FontAwesomeIcons.lightbulb,
          selectedStateIcon: FontAwesomeIcons.solidLightbulb,
          onTap: () => viewModel.toggleCurrentQuestionHint(),
        ),
      ],
    );
  }
}
