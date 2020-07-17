import 'package:YogaAsana/util/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MeditationDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgSrc;
  final String details;

  const MeditationDetailScreen(
      {Key key, this.title, this.imgSrc, this.details, this.subtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * .50,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: size.height * .25,
                  width: size.width * .95,
                  child: Image.asset(imgSrc),
                ),
              ),
              Center(
                child: Container(
                  height: size.height * .62,
                  width: size.width * .96,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                title,
                                style: kHeadingTextStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Text("$subtitle \n $details"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          )),
      // SafeArea(
      //     child: Column(
      //   children: <Widget>[
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Container(
      //       height: size.height * .2,
      //       child: Padding(
      //         padding: const EdgeInsets.only(left: 10.0),
      //         child: Row(
      //           children: <Widget>[
      //             Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   InkWell(
      //                     child: Icon(Icons.arrow_back_ios),
      //                     onTap: () {
      //                       Navigator.pop(context);
      //                     },
      //                   ),
      //                   SizedBox(
      //                     height: size.height * 0.02,
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20.0),
      //                     child: Text(
      //                       title,
      //                       style: TextStyle(
      //                         fontSize: 18,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(height: 10),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20.0),
      //                     child: Text(
      //                       title,
      //                       style: TextStyle(fontWeight: FontWeight.bold),
      //                     ),
      //                   ),
      //                   SizedBox(height: 10),
      //                   SizedBox(
      //                     width:
      //                         size.width * .6, // it just take 60% of total width
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(left: 20.0),
      //                       child: Text(
      //                         details,
      //                       ),
      //                     ),
      //                   ),
      //                 ]),
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 30.0),
      //     Container(
      //       height: size.height * .7,
      //       width: size.width * .94,
      //       child: Card(
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(color: Colors.white70, width: 1),
      //           borderRadius: BorderRadius.circular(50),
                
      //         ),
      //         child: Text("$subtitle \n\n\n $details"),
      //       ),
      //     ),
      //   ],
      // ))
    ]));
  }
}
