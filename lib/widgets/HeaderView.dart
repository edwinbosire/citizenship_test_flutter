import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Stack(
        children: <Widget>[
          Image(
            height: MediaQuery.of(context).size.height,
            image: AssetImage("images/Hero.png"),
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Life in the UK',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 34),
                  ),
                  Text(
                    'TEST',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 30),
                  ),
                  Text(
                    '3rd Edition',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 21),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
