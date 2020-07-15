import 'package:YogaAsana/Class/assets.dart';
import 'package:YogaAsana/Class/models/asana_model.dart';
import 'package:YogaAsana/util/constant.dart';
import 'package:YogaAsana/util/pose_data.dart';
import 'package:flutter/material.dart';

class AsanaScreen extends StatelessWidget {
  static const routeName = '/asana';

  // TODO: Is it private?
  final AsanaModel _asanaModel;

  // TODO: Key argument for constructor?
  const AsanaScreen(this._asanaModel);

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: InkWell(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: size.height * .26,
                    width: size.width * .95,
                    child: Image.network(_asanaModel.imageUrl),
                  ),
                ),
                Center(
                  child: Container(
                    height: size.height * .62,
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
                                  _asanaModel.title,
                                  style: kHeadingTextStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child:
                                    Text(_asanaModel.description),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(
                //     child: RaisedButton(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 50, vertical: 15),
                //         // color: Colors.red[300],
                //         child: Text(
                //           "Let's practice",
                //           style: kHeadingTextStyle,
                //         ),
                //         shape: RoundedRectangleBorder(
                //           side: BorderSide(color: Colors.white70, width: 5),
                //           borderRadius: BorderRadius.circular(50),
                //         ),
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => PracticeTimer(),
                //               // InferencePage(
                //               //   cameras: cameras,
                //               //   title: title,
                //               //   model: model,
                //               //   customModel: customModel,
                //               // ),
                //             ),
                //           );
                //         }),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         titleSpacing: 0,
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         automaticallyImplyLeading: false,
//         brightness: Brightness.light,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: Colors.grey,
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           _asanaModel.title,
//           style: Theme.of(context).textTheme.title,
//         ),
// //        actions: [
// //          IconButton(
// //            icon: Icon(Icons.star_border, color: Colors.yellow[700]),
// //            onPressed: () {},
// //          )
// //        ],
//       ),
//       body: _AsanaScreen(_asanaModel),
//     );
  }
}

// class _AsanaScreen extends StatelessWidget {
//   final AsanaModel asanaModel;

//   const _AsanaScreen(this.asanaModel);

//   Widget _getTextBlock(
//       BuildContext context, String title, String text, Color titleColor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
//           color: titleColor,
//           child: Text(
//             title,
//             maxLines: 1,
//             style: Theme.of(context).textTheme.caption,
//             textAlign: TextAlign.left,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           text,
//           style: Theme.of(context).textTheme.body2,
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: ListView(
//         children: [
//           Image.asset(ImageAssets.asanaArtImage), // TODO: Get image from model
//           SizedBox(height: 15),
//           Button(
//             'Add to favourites',
//             onTap: null,
//           ),
//           SizedBox(height: 15),
//           _getTextBlock(
//             context,
//             'Как выполнять?',
//             asanaModel.description,
//             Colors.tealAccent[200],
//           ),
//           // SizedBox(height: 15),
//           // _getTextBlock(
//           //   context,
//           //   'Чего опасаться?',
//           //   asanaModel.benefits,
//           //   Colors.yellowAccent[200],
//           // ),
//         ],
//       ),
//     );
//   }
// }
