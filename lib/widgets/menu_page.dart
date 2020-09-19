import 'package:flutter/material.dart';
import 'package:life_in_the_uk/screens/QuizPage.dart';
import 'package:life_in_the_uk/utilities/constants.dart';
import 'package:life_in_the_uk/viewModel/exam_view_model.dart';
import 'package:provider/provider.dart';

import 'HeaderView.dart';
import 'MenuListTitle.dart';

class MenuPage extends StatelessWidget {
  final String title;
  const MenuPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: kHeaderHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderView(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                MenuListTile(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ChangeNotifierProvider(
                          create: (_) => ExamViewModel.initWithTestData(),
                          child: QuizPage(),
                        );
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
          ),
        ],
      ),
    );
  }
}
