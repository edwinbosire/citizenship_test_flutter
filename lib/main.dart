import 'package:flutter/material.dart';
import 'package:life_in_the_uk/widgets/menu_page.dart';

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
      home: MenuPage(),
    );
  }
}
