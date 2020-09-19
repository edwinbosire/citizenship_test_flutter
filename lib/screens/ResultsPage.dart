import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_in_the_uk/models/Option.dart';
import 'package:life_in_the_uk/models/Question.dart';
import 'package:life_in_the_uk/viewModel/exam_view_model.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

const Color kDefaultBlue = Color(0xFF1976D2);

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExamViewModel viewModel = context.watch<ExamViewModel>();

    return Scaffold(
      backgroundColor: kDefaultBlue,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context, viewModel),
          _buildQuestionSheetList(viewModels: viewModel.questionsViewModels),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 50.0),
          )
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, ExamViewModel viewModel) => SliverAppBar(
        excludeHeaderSemantics: false,
        backgroundColor: kDefaultBlue,
        centerTitle: false,
        pinned: true,
        floating: true,
        expandedHeight: 305.0,
        title: null,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _closeButton(onTap: () {
            viewModel.resetExam();
            Navigator.pop(context);
          }),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: _redoButton(onTap: () {
              viewModel.resetExam();
            }),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: ResultsHeader(
            viewModel: viewModel,
          ),
        ),
      );

  Widget _closeButton({Function onTap}) => GestureDetector(
        onTap: onTap,
        child: FaIcon(
          FontAwesomeIcons.times,
          size: 24,
          color: Colors.white,
        ),
      );

  Widget _redoButton({Function onTap}) => GestureDetector(
        onTap: onTap,
        child: FaIcon(
          FontAwesomeIcons.redo,
          size: 22,
          color: Colors.white,
        ),
      );

  SliverList _buildQuestionSheetList({List<QuestionViewModel> viewModels}) {
    return SliverList(
      delegate: SliverChildListDelegate(
        viewModels
            .map(
              (questionVM) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          questionVM.title,
                          style: TextStyle(color: Colors.grey, fontSize: 18.0),
                        ),
                      ),
                      ..._buildOptionsList(questionVM),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          questionVM.hint,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Iterable<Widget> _buildOptionsList(QuestionViewModel viewModel) {
    List<Option> options = viewModel.options;

    if (viewModel.questionStatus == QuestionStatus.correct) {
    } else if (viewModel.questionStatus == QuestionStatus.correct) {}

    int index = -1;
    return options.map(
      (option) {
        index++;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SizedBox(
                width: 11,
                child: _buildCheckMark(viewModel, index),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  option.title,
                  style: _buildTextStyle(viewModel, index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckMark(QuestionViewModel viewModel, int index) {
    if (viewModel.answers.contains(index) && viewModel.selectedAnswers.contains(index)) {
      return FaIcon(FontAwesomeIcons.check, size: 13.0, color: Colors.lightGreen);
    } else if (!viewModel.answers.contains(index) && viewModel.selectedAnswers.contains(index)) {
      return FaIcon(FontAwesomeIcons.times, size: 15.0, color: Colors.red);
    } else if (viewModel.answers.contains(index)) {
      return FaIcon(FontAwesomeIcons.check, size: 13.0, color: Colors.blue);
    } else {
      return FaIcon(FontAwesomeIcons.times, size: 15.0, color: Colors.grey);
    }
  }

  TextStyle _buildTextStyle(QuestionViewModel viewModel, int index) {
    if (viewModel.answers.contains(index) && viewModel.selectedAnswers.contains(index)) {
      return TextStyle(color: Colors.green);
    } else if (!viewModel.answers.contains(index) && viewModel.selectedAnswers.contains(index)) {
      return TextStyle(color: Colors.red);
    } else if (viewModel.answers.contains(index)) {
      return TextStyle(color: Colors.blue);
    } else {
      return TextStyle(color: Colors.grey);
    }
  }
}

class ResultsHeader extends StatelessWidget {
  final ExamViewModel viewModel;

  const ResultsHeader({Key key, this.viewModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 285,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: kDefaultBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 5),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 180.0,
                  lineWidth: 15.0,
                  animation: true,
                  percent: viewModel.score,
                  center: Text(
                    ' ${viewModel.score * 100} %',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  footer: Column(
                    children: [
                      Text(
                        viewModel.resultPageDecision(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        viewModel.resultExplanation(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blue[900],
                  backgroundColor: Colors.blue[800],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
