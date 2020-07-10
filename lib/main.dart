import 'package:YogaAsana/main_screen.dart';
import 'package:YogaAsana/util/user.dart';
import 'package:after_layout/after_layout.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Home/screens/login.dart';
import 'Home/screens/register.dart';


List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String email = prefs.getString('email');
  String uid = prefs.getString('uid');
  String displayName = prefs.getString('displayName');
  String photoUrl = prefs.getString('photoUrl');

  User user = User();
  user.setUser({
    'email': email,
    'displayName': displayName,
    'uid': uid,
    'photoUrl': photoUrl,
  });

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(
    email != null && uid != null
        ? MyApp(
            email: user.email,
            uid: user.uid,
            displayName: user.displayName,
            photoUrl: user.photoUrl,
            cameras: cameras,
          )
        : MyApp(
            cameras: cameras,
          ),
  );
}

class MyApp extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  const MyApp({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YogaAsana',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: (email != null && uid != null) ? '/' : '/login',
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) => FirstScreen(),
        '/': (BuildContext context) => MainScreen(
              email: email,
              uid: uid,
              displayName: displayName,
              photoUrl: photoUrl,
              cameras: cameras,
            ),
        '/login': (BuildContext context) => Login(
              cameras: cameras,
            ),
        'register': (BuildContext context) => Register(),
      },
    );
  }
}


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'YogaAsana',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: kBackgroundColor,
//         fontFamily: "Poppins",
//         textTheme:
//             Theme.of(context).textTheme.apply(displayColor: kTitleTextColor),
//       ),
//       home: FirstScreen(),
//     );
//   }
// }

class FirstScreen extends StatefulWidget {
  @override
  FirstScreenState createState() => new FirstScreenState();
}

class FirstScreenState extends State<FirstScreen>
    with AfterLayoutMixin<FirstScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Splash()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(''),
      ),
    );
  }
}



class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new MainScreen(),
      title: new Text(
        'Welcome In YogaAsana App',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset('assets/images/1.png'),
      gradientBackground: new LinearGradient(
          colors: [Colors.red, Colors.yellow],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          title: "Yoga Practice",
          description:
              "Allow miles wound place the leave had. To sitting subject no improve studied limited",
          pathImage: "assets/images/1.png",
          colorBegin: Colors.red,
          colorEnd: Colors.yellow,
          directionColorBegin: Alignment.topRight,
          directionColorEnd: Alignment.bottomLeft
          // backgroundColor: Color(0xfff5a623),
          ),
    );
    slides.add(
      new Slide(
        title: "Meditation",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "assets/images/2.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "Diet Control and Tips",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "assets/images/3.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Splash()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
