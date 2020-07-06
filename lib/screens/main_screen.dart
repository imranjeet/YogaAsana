import '../constant.dart';
import 'yoga_screen.dart';
import 'package:flutter/material.dart';
import 'diet_screen.dart';
import 'exercise_screen.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.round();
      });
    });
  }

  void _changePage(int page) {
    setState(() {
      this._currentPage = page;
    });

    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Home(),
          YogaScreen(),
          DietScreen(),
          ExerciseScreen(),
        ],
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text('Diet')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Settings')),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kDeathColor,
        unselectedItemColor: Colors.black45,
        unselectedIconTheme: IconThemeData(
          size: 30,
        ),
        selectedIconTheme: IconThemeData(
          size: 35,
        ),
        currentIndex: _currentPage,
        onTap: _changePage,
      ),
    );
  }
}
