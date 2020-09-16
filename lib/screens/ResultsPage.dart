import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_in_the_uk/models/Option.dart';
import 'package:life_in_the_uk/models/OptionStatus.dart';
import 'package:life_in_the_uk/viewModel/exam_view_model.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultsPage extends StatefulWidget {
  final ExamViewModel viewModel;

  const ResultsPage({Key key, this.viewModel}) : super(key: key);
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildQuestionSheetList(viewModels: widget.viewModel.questionsViewModels),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 50.0),
          )
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() => SliverAppBar(
        excludeHeaderSemantics: false,
        backgroundColor: Colors.blue[700],
        centerTitle: false,
        pinned: true,
        floating: true,
        expandedHeight: 305.0,
        title: null,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _closeButton(onTap: () => Navigator.pop(context)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: _redoButton(onTap: () => print('redo')),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: ResultsHeader(
            viewModel: widget.viewModel,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          questionVM.title,
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      ..._buildOptionsList(questionVM.options),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Iterable<Widget> _buildOptionsList(List<Option> options) {
    return options.map(
      (option) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.check,
                size: 14.0,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                option.title,
                style: TextStyle(color: option.status == OptionStatus.correct ? Colors.blue : Colors.grey),
              ),
            ],
          ),
        );
      },
    );
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
                  color: Colors.blue[700],
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
                        "You have failed this quiz",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'The pass mark required is 75%',
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
