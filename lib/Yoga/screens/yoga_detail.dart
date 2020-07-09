import 'package:YogaAsana/constant.dart';
import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/Yoga/screens/yoga_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
            height: size.height * .45,
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
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
                      height: size.height * .25,
                      child: CachedNetworkImage(
                        height: size.height * .25,
                        width: size.width * .95,
                        imageUrl: yogaPost.gifUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.black),
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Container(
                            child: Column(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: yogaPost.featuredImageUrl,
                              height: size.height * .25,
                              errorWidget: (context, url, error) => Container(
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
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: size.height * .63,
                  width: size.width * .96,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              yogaPost.title,
                              style: kHeadingTextStyle,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Html(data: yogaPost.details),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
