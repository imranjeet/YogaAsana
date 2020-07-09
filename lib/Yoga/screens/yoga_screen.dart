import 'package:YogaAsana/Yoga/widgets/grid_yoga_items.dart';
import 'package:YogaAsana/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class YogaScreen extends StatefulWidget {
  @override
  _YogaScreenState createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderWidget(
                      title: "Yoga Practice",
                      subtitle: "",
                      details: "",
                      imgSrc: "assets/images/1.png"),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: GridYogaItems()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
