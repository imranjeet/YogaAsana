import 'package:YogaAsana/util/user.dart';
import 'package:camera/camera.dart';

import 'Home/screens/profile.dart';
import 'Meditation/screens/meditation_screen.dart';
import 'Yoga/screens/yoga_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'screens/diet_screen.dart';
import 'screens/exercise_screen.dart';
import 'Home/screens/home.dart';

class MainScreen extends StatefulWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  const MainScreen({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });
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
    User user = User();
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Home(
            email: user.email,
            uid: user.uid,
            displayName: user.displayName,
            photoUrl: user.photoUrl,
            cameras: cameras,
          ),
          // YogaScreen(),
          MeditationScreen(),
          Profile(
            email: user.email,
            uid: user.uid,
            displayName: user.displayName,
            photoUrl: user.photoUrl,
          ),
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
              icon: Icon(Icons.fastfood), title: Text('Meditation')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Settings')),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFFF4848),
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
