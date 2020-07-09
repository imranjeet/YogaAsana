import 'package:YogaAsana/home_screen.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String details;
  final String imgSrc;

  const HeaderWidget({
    Key key,
    @required this.title,
    this.subtitle,
    this.details,
    this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return MainScreen();
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
            width: size.width * .6, // it just take 60% of total width
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                details,
              ),
            ),
          ),
        ]),
        Container(
          height: 150,
          width: 100,
          child: Image.asset(imgSrc),
        ),
      ],
    );
  }
}
