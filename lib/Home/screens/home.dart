import 'package:YogaAsana/Home/widgets/grid_yoga_items.dart';
import 'package:YogaAsana/util/user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: size.height * .20,
                            width: size.width * .5,
                            child: Center(child: Text("Good morning \n${user.displayName}", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Poppins", fontWeight: FontWeight.bold,),))),
                          Container(
                            height: size.height * .2,
                            width: size.width * .3,
                            child: Image.asset("assets/images/1.png"),
                          ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () => Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Profile(
                      //         email: user.email,
                      //         uid: user.uid,
                      //         displayName: user.displayName,
                      //         photoUrl: user.photoUrl,
                      //       ),
                      //     ),
                      //   ),
                      //   child: Container(
                      //     height: 60,
                      //     width: 60,
                      //     child: CircleAvatar(
                      //         // backgroundColor: Colors.purpleAccent,
                      //         radius: 10,
                      //         child: user.photoUrl == null
                      //             ?
                      //             // ? Icon(Icons.person_add, size: 40,)
                      //             Image.asset('assets/images/profile-image.png')
                      //             : CachedNetworkImage(
                      //                 imageUrl: user.photoUrl,
                      //                 errorWidget: (context, url, error) =>
                      //                     Container(
                      //                         child: Column(
                      //                   children: <Widget>[
                      //                     Icon(
                      //                       Icons.error,
                      //                       size: 50,
                      //                     ),
                      //                     Text(
                      //                       "check your internet connection!",
                      //                     ),
                      //                   ],
                      //                 )),
                      //               )),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: Text(
                      //     "Yoga Practice",
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
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
  }
}


