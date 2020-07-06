import 'package:YogaAsana/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YogaAsana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: Theme.of(context).textTheme.apply(displayColor: kTitleTextColor),),
      home: MainScreen(),
    );
  }
}
