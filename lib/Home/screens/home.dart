import 'package:YogaAsana/Home/screens/login.dart';
import 'package:YogaAsana/Home/screens/profile.dart';
import 'package:YogaAsana/Home/widgets/grid_yoga_items.dart';
import 'package:YogaAsana/main.dart';
import 'package:YogaAsana/util/auth.dart';
import 'package:YogaAsana/util/user.dart';
import 'package:YogaAsana/widgets/header_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  const Home({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    User user = User();
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * .40,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              email: user.email,
                              uid: user.uid,
                              displayName: user.displayName,
                              photoUrl: user.photoUrl,
                            ),
                          ),
                        ),
                        child: Container(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                              // backgroundColor: Colors.purpleAccent,
                              radius: 10,
                              child: user.photoUrl == null
                                  ?
                                  // ? Icon(Icons.person_add, size: 40,)
                                  Image.asset('assets/images/profile-image.png')
                                  : CachedNetworkImage(
                                      imageUrl: user.photoUrl,
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
                                    )),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Yoga Practice",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //   SizedBox(height: 10),
                      //   Padding(
                      //     padding: const EdgeInsets.only(left: 20.0),
                      //     child: Text(
                      //       subtitle,
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      //   SizedBox(height: 10),
                      //   SizedBox(
                      //     width: size.width * .6, // it just take 60% of total width
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 20.0),
                      //       child: Text(
                      //         details,
                      //       ),
                      //     ),
                      //   ),
                      //
                    ]),
                Container(
                  // padding: EdgeInsets.only(right: 100,),
                  height: 150,
                  width: 100,
                  child: Image.asset("assets/images/1.png"),
                ),
                // IconButton(
                //   icon: Icon(Icons.exit_to_app),
                //   onPressed: () async {
                //     Auth auth = Auth();
                //     await auth.signOut();
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Login(
                //           cameras: cameras,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: GridYogaItems(
                        // cameras: cameras,
                        // model:
                        //     "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
                        // asanas: asanas,
                        )),
              ],
            ),
          ),
        ),
      ],
    );
    // return Stack(
    //   children: <Widget>[
    //     Container(
    //       height: size.height * .45,
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //             begin: Alignment.topRight,
    //             end: Alignment.bottomLeft,
    //             colors: [
    //               Colors.redAccent,
    //               Colors.yellowAccent,
    //             ]),
    //         image: DecorationImage(
    //           alignment: Alignment.centerLeft,
    //           image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
    //         ),
    //       ),
    //     ),
    //     SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 15),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Column(
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 50),
    //                       child: Text(
    //                         "YogaAsana",
    //                         style: TextStyle(
    //                           fontFamily: "Poppins",
    //                           fontSize: 24,
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       child: Image.asset("assets/images/101.png"),
    //                     ),
    //                   ],
    //                 ),
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: Container(
    //                     alignment: Alignment.center,
    //                     height: 200,
    //                     width: 150,
    //                     child: Image.asset("assets/images/1.png"),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Expanded(
    //               child: GridView.count(
    //                 crossAxisCount: 2,
    //                 childAspectRatio: .75,
    //                 crossAxisSpacing: 20,
    //                 mainAxisSpacing: 20,
    //                 children: <Widget>[
    //                   ItemCard(
    //                     title: "Yoga",
    //                     imgSrc: "assets/images/5.png",
    //                     press: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(builder: (context) {
    //                           return YogaScreen();
    //                         }),
    //                       );
    //                     },
    //                   ),
    //                   ItemCard(
    //                     title: "Meditation",
    //                     imgSrc: "assets/images/4.png",
    //                     press: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(builder: (context) {
    //                           return MeditationScreen();
    //                         }),
    //                       );
    //                     },
    //                   ),
    //                   ItemCard(
    //                     title: "Diet Recommendation",
    //                     imgSrc: "assets/images/2.png",
    //                     press: () {},
    //                   ),
    //                   ItemCard(
    //                     title: "Kegel Exercises",
    //                     imgSrc: "assets/images/3.png",
    //                     press: () {},
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

// class CircleProfileImage extends StatefulWidget {
//   final User user;

//   const CircleProfileImage({Key key, this.user}) : super(key: key);

//   @override
//   _CircleProfileImageState createState() => _CircleProfileImageState();
// }

// class _CircleProfileImageState extends State<CircleProfileImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: 'profile',
//       child: Center(
//         child: CircleAvatar(
//           radius: 15,
//           backgroundImage: user.photoUrl.isEmpty
//               ? AssetImage(
//                   'assets/images/profile-image.png',
//                 )
//               : NetworkImage(user.photoUrl),
//         ),
//       ),
//     );
//   }
// }
// class CircleProfileImage extends StatefulWidget {
//   final String user;
//   const CircleProfileImage({this.user});

//   @override
//   _CircleProfileImageState createState() => _CircleProfileImageState(user);
// }

// class _CircleProfileImageState extends State<CircleProfileImage> {
//   final User user;

//   _CircleProfileImageState(this.user);
//   @override
//   Widget build(BuildContext context) {
// return Hero(
//   tag: 'profile',
//   child: Center(
//     child: CircleAvatar(
//       radius: 15,
//       backgroundImage: user.photoUrl.isEmpty
//           ? AssetImage(
//               'assets/images/profile-image.png',
//             )
//           : NetworkImage(user.photoUrl),
//     ),
//   ),
// );
//   }
// }
