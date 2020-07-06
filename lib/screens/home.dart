import 'package:YogaAsana/widgets/item_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            "YogaAsana",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/images/101.png"),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 150,
                        child: Image.asset("assets/images/1.png"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      ItemCard(
                        title: "Diet Recommendation",
                        imgSrc: "assets/images/2.png",
                        press: () {},
                      ),
                      ItemCard(
                        title: "Kegel Exercises",
                        imgSrc: "assets/images/3.png",
                        press: () {},
                      ),
                      ItemCard(
                          title: "Meditation",
                          imgSrc: "assets/images/4.png",
                          press: () {}
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) {
                          //       return DetailsScreen();
                          //     }),
                          //   );
                          // },
                          ),
                      ItemCard(
                        title: "Yoga",
                        imgSrc: "assets/images/5.png",
                        press: () {},
                      ),
                      ItemCard(
                        title: "Diet Recommendation",
                        imgSrc: "assets/images/2.png",
                        press: () {},
                      ),
                      ItemCard(
                        title: "Kegel Exercises",
                        imgSrc: "assets/images/3.png",
                        press: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
