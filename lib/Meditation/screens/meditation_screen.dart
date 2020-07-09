import 'package:YogaAsana/Meditation/screens/meditaion_details_screen.dart';
import 'package:YogaAsana/widgets/header_widget.dart';
import 'package:YogaAsana/Meditation/widgets/meditation_track.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class MeditationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.redAccent,
                    Colors.yellowAccent,
                  ]),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: HeaderWidget(
                    title: "Meditation",
                    subtitle: "3-10 MIN Course",
                    details:
                        "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                    imgSrc: "assets/images/1.png",
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MusicItem(),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .55,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Text(
                          "Meditation",
                          style: kHeadingTextStyle,
                        ),
                        MeditationItem(
                          title: "Basic 1",
                          subtitle: "Start your deepen you practice",
                          details:
                              "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                        ),
                        MeditationItem(
                          title: "Basic 2",
                          subtitle: "Start your deepen you practice",
                          details:
                              "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                        ),
                        MeditationItem(
                          title: "Basic 3",
                          subtitle: "Start your deepen you practice",
                          details:
                              "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                        ),
                        MeditationItem(
                          title: "Basic 4",
                          subtitle: "Start your deepen you practice",
                          details:
                              "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MeditationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String details;

  const MeditationItem({
    Key key,
    this.title,
    this.subtitle,
    this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeditationDetailScreen(
                    title: title,
                    subtitle: subtitle,
                    details: details,
                  ))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.all(10),
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 23,
              spreadRadius: -13,
              color: kShadowColor,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/2.png",
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: kTitleTextstyle,
                  ),
                  Text(subtitle),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/gif/1.gif",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
