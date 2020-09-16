import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationBarButtonItem extends StatelessWidget {
  final bool selected;
  final IconData normalStateIcon;
  final IconData selectedStateIcon;
  final Function onTap;

  const NavigationBarButtonItem(
      {Key key,
      this.selected = false,
      this.normalStateIcon,
      this.selectedStateIcon,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedCrossFade(
            duration: kThemeAnimationDuration,
            firstChild: FaIcon(normalStateIcon),
            secondChild: FaIcon(selectedStateIcon),
            crossFadeState:
                selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ),
      ),
    );
  }
}
