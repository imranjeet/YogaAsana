import 'package:YogaAsana/Meditation/screens/meditation_screen.dart';
import 'package:flutter/material.dart';

class MeditationDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String details;

  const MeditationDetailScreen(
      {Key key, this.title, this.details, this.subtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * .40,
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
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: size.height * .2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.arrow_back_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return MeditationScreen();
                              }),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            subtitle,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width:
                              size.width * .6, // it just take 60% of total width
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              details,
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: size.height * .7,
            width: size.width * .94,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ))
    ]));
  }
}
