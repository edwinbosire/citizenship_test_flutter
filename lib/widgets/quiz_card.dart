import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:life_in_the_uk/models/OptionStatus.dart';
import 'package:life_in_the_uk/models/Question.dart';
import 'package:life_in_the_uk/viewModel/exam_view_model.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';
import 'package:provider/provider.dart';

import 'ExplanationTile.dart';
import 'OptionListTile.dart';
import 'QuestionHeader.dart';

class QuizCard extends StatefulWidget {
  final int pageIndex;
  final Function onOptionSelection;

  const QuizCard({
    Key key,
    this.pageIndex,
    this.onOptionSelection,
  }) : super(key: key);

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  ScrollController _scrollController;
  static final sinePeriod = 2 * pi;
  double _endValue = 0;
  bool shouldScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamViewModel>(
      builder: (context, examViewModel, child) {
        QuestionViewModel questionViewModel = context.watch<QuestionViewModel>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: 25.0),
                itemCount: (questionViewModel.numberOfOptions + 2),
                // Two divider top and bottom
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  indent: (index == 0 || index == questionViewModel.numberOfOptions) ? 0 : 20,
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ChangeNotifierProvider.value(
                      value: questionViewModel,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100),
                          QuestionHeader(),
                          SizedBox(height: 120),
                        ],
                      ),
                    );
                  } else if (index == questionViewModel.numberOfOptions + 1) {
                    // ignore: unnecessary_statements
                    (questionViewModel.showHint) ? _scrollToBottom() : (shouldScrollToTop) ? _scrollToTop() : null;
                    return ChangeNotifierProvider.value(
                      value: questionViewModel,
                      child: ExplanationTile(),
                    );
                  } else {
                    return ChangeNotifierProvider.value(
                      value: questionViewModel,
                      child: AlertWiggle(
                        index: index - 1,
                        child: OptionsListTile(
                          title: questionViewModel.options[index - 1].title,
                          status: questionViewModel.options[index - 1].status,
                          onTap: () => _handleOptionSelection(examViewModel, questionViewModel, index - 1),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleOptionSelection(ExamViewModel examViewModel, QuestionViewModel questionViewModel, int index) {
    if (questionViewModel.shouldAllowSelection()) {
      QuestionStatus status = examViewModel.updateCurrentQuestionWithSelection(index);

      if (status == QuestionStatus.correct) {
        widget.onOptionSelection();
      } else if (status == QuestionStatus.incorrect) {
        questionViewModel.showHint = true;
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    shouldScrollToTop = true;
    Timer(Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }
}

class AlertWiggle extends StatelessWidget {
  AlertWiggle({this.index, this.child});

  final Widget child;
  final int index;
  static final sinePeriod = 2 * pi;
  double _endValue = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionViewModel>(builder: (_, questionViewModel, __) {
      if (questionViewModel.options[index].status == OptionStatus.incorrect) {
        _endValue = sinePeriod;
      }

      return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: _endValue),
        duration: Duration(milliseconds: 300),
        child: child,
        builder: (_, double value, Widget child) {
          double offset = sin(value);
          return Transform.translate(
            offset: Offset(offset * 15, 0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: value == 0 || value == _endValue ? 0 : 3,
              child: child,
            ),
          );
        },
      );
    });
  }
}
