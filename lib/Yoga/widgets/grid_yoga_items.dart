import 'dart:convert';

import 'package:YogaAsana/models/yoga_post.dart';
import 'package:YogaAsana/services/yoga_post_service.dart';
import 'package:YogaAsana/widgets/ProgressWidget.dart';
import 'package:YogaAsana/Yoga/widgets/yoga_card.dart';
import 'package:flutter/material.dart';


class GridYogaItems extends StatefulWidget {
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
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .95,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (contaxt, index) {
                  return YogaCard(
                    yogaPost: snapshot.data[index],
                  );
                });
          } else {
            return circularProgress();
          }
        });
  }
}
