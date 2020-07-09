import 'package:YogaAsana/home_screen.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

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
        textTheme:
            Theme.of(context).textTheme.apply(displayColor: kTitleTextColor),
      ),
      home: FirstScreen(),
    );
  }
}

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

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Hello'),
//       ),
//       body: new Center(
//         child: new Text('This is the second page'),
//       ),
//     );
//   }
// }

// class IntroScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('IntroScreen'),
//       ),
//       body: new Center(
//         child: new Text('This is the IntroScreen'),
//       ),
//     );
//   }
// }

// class FirstScreen extends StatefulWidget {
//   @override
//   _FirstScreenState createState() => _FirstScreenState();
// }

// class _FirstScreenState extends State<FirstScreen> {
//   @override
//   void initState() {
//     super.initState();
//     getSaveData();
//   }

//   Future<bool> getSaveData() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool isIntroScreenOpenedBefore =
//         sharedPreferences.getBool("isIntroScreenOpened") ?? false;
//     print(sharedPreferences.containsKey("isIntroScreenOpened")); // check your key either it is save or not?

//     if (isIntroScreenOpenedBefore == true) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return IntroScreen();
//       }));
//     } else {
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return Splash();
//       }));
//     }
//     return isIntroScreenOpenedBefore;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getSaveData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return circularProgress();
//           } else {
//             return MaterialApp(
//                 title: 'YogaAsana',
//                 theme: ThemeData(
//                   scaffoldBackgroundColor: kBackgroundColor,
//                   fontFamily: "Poppins",
//                   textTheme: Theme.of(context)
//                       .textTheme
//                       .apply(displayColor: kTitleTextColor),
//                 ),
//                 debugShowCheckedModeBanner: false,
//                 initialRoute: snapshot.data,
//                 routes: {
//                   IntroScreen.id: (context) => IntroScreen(),
//                   Splash.id: (context) => Splash(),
//                 });
//           }
//         });
//   }
// }

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
