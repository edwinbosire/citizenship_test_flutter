import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_in_the_uk/models/OptionStatus.dart';

class OptionsListTile extends StatelessWidget {
  final String title;
  final OptionStatus status;
  final Function onTap;
  const OptionsListTile({Key key, this.status, this.onTap, this.title}) : super(key: key);

  Color _textColor(BuildContext context) {
    return status == OptionStatus.notSelected ? Theme.of(context).textTheme.headline4.color : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Material(
        color: (status == OptionStatus.notSelected) ? Colors.white : (status == OptionStatus.incorrect) ? Colors.redAccent : Colors.green,
        child: InkWell(
          onTap: onTap,
          splashColor: (status == OptionStatus.correct) ? Colors.green[900] : Colors.red[900],
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: kThemeAnimationDuration,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 3),
                    firstChild: FaIcon(
                      FontAwesomeIcons.circle,
                      color: Colors.grey[300],
                    ),
                    secondChild: FaIcon(
                      (status == OptionStatus.correct) ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.timesCircle,
                      color: Colors.white,
                    ),
                    crossFadeState: status == OptionStatus.notSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline5.copyWith(color: _textColor(context)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
