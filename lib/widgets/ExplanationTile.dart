import 'package:flutter/material.dart';
import 'package:life_in_the_uk/viewModel/question_view_model.dart';

class ExplanationTile extends StatelessWidget {
  const ExplanationTile({
    Key key,
    @required bool showHint,
    @required this.questionViewModel,
  })  : _showHint = showHint,
        super(key: key);

  final bool _showHint;
  final QuestionViewModel questionViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedCrossFade(
        crossFadeState:
            _showHint ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
        firstChild: Container(
          height: 150,
        ),
        secondChild: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
          child: RichText(
            text: TextSpan(
              text: '⬇ Explanation \n \n',
              style: TextStyle(
                  color: Colors.blue[800], fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: questionViewModel.hint,
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
