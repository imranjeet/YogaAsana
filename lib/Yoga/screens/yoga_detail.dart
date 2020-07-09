import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/Yoga/screens/yoga_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class YogaDetail extends StatelessWidget {
  final YogaPost yogaPost;

  const YogaDetail({Key key, this.yogaPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .50,
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return YogaScreen();
                        }),
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: size.height * .35,
                          child: CachedNetworkImage(
                            imageUrl: yogaPost.gifUrl,
                            progressIndicatorBuilder: (context, url,
                                    downloadProgress) =>
                                CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.black),
                                    value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Container(
                                child: Column(
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: yogaPost.featuredImageUrl,
                                  height:
                                      MediaQuery.of(context).size.height * .35,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                      Text(
                                        "check your internet connection!",
                                      ),
                                    ],
                                  )),
                                )
                                // Icon(
                                //   Icons.error,
                                //   size: 50,
                                // ),
                                // Text(
                                //   "check your internet connection!",
                                // ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
