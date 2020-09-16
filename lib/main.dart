import 'package:flutter/material.dart';
import 'package:life_in_the_uk/screens/QuizPage.dart';
import 'package:life_in_the_uk/widgets/HeaderView.dart';
import 'package:life_in_the_uk/widgets/MenuListTitle.dart';
import 'package:stretchy_header/stretchy_header.dart';

import 'utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life in the UK Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF0472B2),
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StretchyHeader.listView(
        headerData: HeaderData(
          headerHeight: kHeaderHeight,
          header: HeaderView(),
        ),
        children: <Widget>[
          MenuListTile(
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return QuizPage();
                }),
              );
            },
            iconName: 'Mock',
            title: 'Mock Exam',
            subTitle: '24 Practise questions to prepare you for the test',
          ),
          MenuListTile(
            onPress: () {},
            iconName: 'Practice',
            title: 'Practice Questions',
            subTitle: '1,000+ Questions to practice',
          ),
          MenuListTile(
            onPress: () {},
            iconName: 'Revision',
            title: 'Revision',
            subTitle: 'All the reading material needed for the test',
          ),
          MenuListTile(
            onPress: () {},
            iconName: 'Tips',
            title: 'Tips to pass the test',
            subTitle: 'Helpful tips to help you pass the exam',
          ),
          MenuListTile(
            onPress: () {},
            iconName: 'Rate',
            title: 'Rate Us',
          ),
        ],
      ),
    );
  }
}
