import 'package:flutter/material.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';
import 'package:provider/provider.dart';

class ExplanationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionViewModel>(
      builder: (context, questionViewModel, child) {
        return Container(
          child: AnimatedCrossFade(
            crossFadeState: questionViewModel.showHint ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: kThemeAnimationDuration,
            firstChild: Container(
              height: 150,
            ),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: RichText(
                text: TextSpan(
                  text: '⬇ Explanation \n \n',
                  style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: questionViewModel.hint,
                      style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
