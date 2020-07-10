import 'package:YogaAsana/main.dart';
import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/Home/screens/yoga_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class YogaCard extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String customModel;
  final String asana;
  final YogaPost yogaPost;
  
  const YogaCard({
    Key key,
    this.yogaPost,
    this.asana, this.customModel, this.cameras,
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
                            cameras: cameras,
                            // title: customModelName,
                            model:
                                customModel,
                            // customModel: customModelName,
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

                  // CachedNetworkImage(imageUrl: img),
                  // Image.network(img),
                  // Image.asset(imgSrc, height: 80,),
                  Spacer(),
                  Text(
                    yogaPost.title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: kSubTextStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
