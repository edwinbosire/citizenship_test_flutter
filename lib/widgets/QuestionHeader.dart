import 'package:flutter/material.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';

class QuestionHeader extends StatelessWidget {
  final QuestionViewModel question;
  final int index;
  final int totalQuestions;

  QuestionHeader({this.index = 0, this.question, this.totalQuestions = 24});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(
              'Question $index of $totalQuestions',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              question.title,
              style: TextStyle(color: Colors.blueGrey[800], fontSize: 34.0),
            ),
          ),
        ),
      ],
    );
  }
}
