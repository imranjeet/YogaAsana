import 'package:YogaAsana/util/user.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import 'Class/screens/classrooms_screen.dart';
import 'Class/stores/asanas_store.dart';
import 'Class/stores/classrooms_store.dart';
import 'Profile/screens/profile.dart';
import 'Meditation/screens/meditation_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';
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

  bool _isCleaning = false;

  void _clearAndRefresh(BuildContext context) async {
    setState(() => _isCleaning = true);

    try {
      final asanasStore = Provider.of<AsanasStore>(context, listen: false);
      final classroomsStore = Provider.of<ClassroomsStore>(context, listen: false);

      await asanasStore.refreshData();
      await classroomsStore.refreshData();

      // _showNotification(context);
    } catch (_) {
      // _showNotification(context, isError: true);
    } finally {
      setState(() => _isCleaning = false);
    }
  }



  bool activeMeditationIcon = false;
  PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.round();
        if (_currentPage == 2) {
          activeMeditationIcon = true;
        } else {
          activeMeditationIcon = false;
        }
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
            // cameras: cameras,
          ),
          ClassroomsScreen(),
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
              icon: Icon(Icons.class_),
              title: Text(
                'Classes',
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/2.png',
                height: 30,
                color: activeMeditationIcon ? Colors.pink : Colors.black54,
              ),
              title: Text('Meditation')),
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
