import 'package:flutter/material.dart';

import '../util/constant.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/net.jpg"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "check your internet connection!",
              style: kTitleTextstyle,
            ),
          ),
          InkWell(
              child: Icon(
                Icons.refresh,
                size: 50,
                color: Colors.blue,
              ),
              onTap: () {})
        ],
      ),
    );
  }
}