import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/Home/screens/yoga_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../util/constant.dart';

class YogaCard extends StatelessWidget {
  final YogaPost yogaPost;

  const YogaCard({
    Key key,
    this.yogaPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => YogaDetail(
                            yogaPost: yogaPost,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  CachedNetworkImage(
                    imageUrl: yogaPost.featuredImageUrl,
                    errorWidget: (context, url, error) => Container(
                        child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          size: 50,
                        ),
                        Text(
                          "check your internet connection!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  Spacer(),
                  Text(
                    yogaPost.title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: kSubTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
