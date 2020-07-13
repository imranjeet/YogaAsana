import 'dart:convert';

import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/services/yoga_post_service.dart';
import 'package:YogaAsana/util/pose_data.dart';
import 'package:YogaAsana/widgets/ProgressWidget.dart';
import 'package:YogaAsana/Home/widgets/yoga_card.dart';
import 'package:flutter/material.dart';

class GridYogaItems extends StatefulWidget {
  // final List<CameraDescription> cameras;
  // final String model;

  // const GridYogaItems({Key key, this.cameras, this.model}) : super(key: key);
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
      print(blogPosts);
      blogPosts.forEach((blogPost) {
        var model = YogaPost();
        model.title = blogPost['title'];
        model.details = blogPost['details'];
        model.featuredImageUrl = blogPost['featured_image_url'];
        model.gifUrl = blogPost['gif_image_url'];
        // model.category = blogPost['category'];
        // model.createdAt = blogPost['created_at'];
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
                  itemCount: 13,
                  itemBuilder: (
                    BuildContext contaxt,
                    int index,
                  ) {
                    return YogaCard(
                      yogaPost: snapshot.data[index],
                      // cameras: cameras,
                      title: asanas[index],
                      model:
                          "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
                      customModel: asanas[index],
                    );
                  }),
            );
          }
          // else if (snapshot.hasError) {
          //   return Text("${snapshot.error}");
          // }
          else {
            return circularProgress();
          }
        });
  }

  // void _onSelect(
  //     BuildContext context, String customModelName, YogaPost yogaPost) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => YogaDetail(
  //         // cameras: cameras,
  //         yogaPost: yogaPost,
  //         title: customModelName,
  //         model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
  //         customModel: customModelName,
  //       ),
  //     ),
  //   );
  // }
}
