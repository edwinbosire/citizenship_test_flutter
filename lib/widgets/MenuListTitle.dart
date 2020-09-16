import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class MenuListTile extends StatelessWidget {
  final String iconName;
  final String title;
  final String subTitle;
  final Function onPress;

  const MenuListTile({
    Key key,
    @required this.iconName,
    @required this.title,
    this.subTitle = '',
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: kMenuItemVerticalPadding),
          child: ListTile(
            leading: Image(
              image: AssetImage('images/$iconName.png'),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.blueGrey[800]),
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }
}
