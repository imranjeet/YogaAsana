import 'dart:convert';

import 'package:YogaAsana/main.dart';
import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/services/yoga_post_service.dart';
import 'package:YogaAsana/util/pose_data.dart';
import 'package:YogaAsana/widgets/ProgressWidget.dart';
import 'package:YogaAsana/Home/widgets/yoga_card.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GridYogaItems extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String model;
  final List<String> asanas;
  const GridYogaItems({Key key, this.model, this.asanas, this.cameras})
      : super(key: key);
  @override
  _GridYogaItemsState createState() => _GridYogaItemsState();
}

class _GridYogaItemsState extends State<GridYogaItems> {
  YogaPostService _yogaPostService = YogaPostService();

  Future<List<YogaPost>> _getAllYogaPost() async {
    var result = await _yogaPostService.getAllYogaPost();
    List<YogaPost> _list = List<YogaPost>();
    if (result != null) {
      var blogPosts = json.decode(result.body);
      blogPosts.forEach((blogPost) {
        var model = YogaPost();
        model.title = blogPost['title'];
        model.details = blogPost['details'];
        model.featuredImageUrl = blogPost['featured_image_url'];
        model.gifUrl = blogPost['gif_image_url'];
        model.category = blogPost['category']['name'];
        model.createdAt = blogPost['created_at'];
        setState(() {
          _list.add(model);
        });
      });
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<YogaPost>>(
        future: _getAllYogaPost(),
        builder:
            (BuildContext contaxt, AsyncSnapshot<List<YogaPost>> snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .95,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext contaxt, int index,) {
                    return YogaCard(
                      cameras: cameras,
                      customModel:
                          "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
                      
                      asana: asanas[index],
                      yogaPost: snapshot.data[index],
                    );
                  }),
            );
          } else {
            return circularProgress();
          }
        });
  }
}
