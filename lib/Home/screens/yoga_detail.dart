import 'package:YogaAsana/Timer/timer.dart';
import 'package:YogaAsana/util/constant.dart';
import 'package:YogaAsana/models/yoga_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class YogaDetail extends StatelessWidget {
  final YogaPost yogaPost;

  const YogaDetail({
    Key key,
    this.yogaPost,
  }) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                  height: size.height * .26,
                  width: size.width * .95,
                  child: CachedNetworkImage(
                    imageUrl: yogaPost.featuredImageUrl,
                    height: size.height * .25,
                    width: size.width * .95,
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
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: size.height * .50,
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Center(
                  child: RaisedButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 13),
                      // color: Colors.red[300],
                      child: Text(
                        "Let's practice",
                        style: kHeadingTextStyle,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PracticeTimer(
                              imgSrc: yogaPost.featuredImageUrl,
                              yogaPost: yogaPost,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
