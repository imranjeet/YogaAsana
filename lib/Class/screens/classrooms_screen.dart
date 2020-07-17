import 'dart:math';

import 'package:YogaAsana/Class/assets.dart';
import 'package:YogaAsana/Class/i18n/plural.dart';
import 'package:YogaAsana/Class/models/classroom_model.dart';
import 'package:YogaAsana/Class/screens/classroom_screen.dart';
import 'package:YogaAsana/Class/screens/new_classroom/new_classroom_screen.dart';
import 'package:YogaAsana/Class/stores/classrooms_store.dart';
import 'package:YogaAsana/Class/stores/new_classroom_store.dart';
import 'package:YogaAsana/Class/utils/local_notification.dart';
import 'package:YogaAsana/Class/utils/log.dart';
import 'package:YogaAsana/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// const List<String> emojiForClassroom = [
//   '🙏',
//   '😌',
//   '😬',
//   '😮',
//   '💪',
//   '✌️',
//   '👀',
//   '🐰',
//   '🐼',
//   '🐵',
// ];

class ClassroomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * .46,
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
            children: <Widget>[
              SizedBox(height: size.height * .02),
              Text(
                "Yoga Classes",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * .01),
              Text("Create your own yoga classes"),
              SizedBox(height: size.height * .03),
              _PredefinedClassesList(),
              SizedBox(height: size.height * .01),
              _ActiveClassesList(),
              SizedBox(height: size.height * .01),
              _CreateClass(),
            ],
          ),
        ),
      ],
    );
  }
}

class _PredefinedClassesList extends StatelessWidget {
  Widget _getListItem(
      String title, Color bgColor, String imageAsset, Size size) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(15),
        child: Container(
          // height: size.height * .20,
          // width: sizeW,
          // padding: EdgeInsets.all(5),
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
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Container(
                    height: size.height * .15,
                    width: 100,
                    child: Image(
                      image: AssetImage(imageAsset),
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height * 0.24,
      child: Consumer<ClassroomsStore>(
        builder: (_, store, __) {
          return Observer(
            builder: (_) {
              if (store.predefinedClassrooms.isEmpty) {
                return SizedBox.shrink(); // TODO: Empty list
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: store.predefinedClassrooms.length,
                // scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  final classroom = store.predefinedClassrooms[index];

                  final images = <String>[
                    ImageAssets.classroomMeditateImage,
                    ImageAssets.classroomVitalityImage,
                    ImageAssets.classroomMomsImage,
                  ];

                  return GestureDetector(
                    child: _getListItem(
                      classroom.title,
                      Colors.amber[200],
                      images[index],
                      size,
                      // sizeW,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ClassroomScreen(classroom: classroom);
                        },
                      ));
                    },
                  );
                  // SizedBox(
                  //     width: index == store.predefinedClassrooms.length - 1
                  //         ? 0
                  //         : 5),
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _ActiveClassesList extends StatelessWidget {
  Widget _classroomListItem(ClassroomModel classroom, BuildContext context) {
    var size = MediaQuery.of(context).size;
    final rand = Random();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white70,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(
            "assets/icons/5.png",
            height: size.height * .1,
          ),
          // emojiForClassroom[rand.nextInt(9)],
          // textScaleFactor: 2.8,

          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0, left: 10),
            child: Text(
              classroom.title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 5.0, left: 10),
            child: Text(
              '${asanasCount(classroom.classroomRoutines.length)}'
              ' • ${classroomTimeRounded(classroom.totalDuration)}',
              maxLines: 1,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),

          // onTap: () {
          //   _showTermsDialog(
          //     context,
          //     "Terms & Conditions",
          //   );
          // },
        ),
      ),
    );
//     Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey[200], width: 2),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               gradient: LinearGradient(
// //                colors: [Color(0x99FF7D14), Color(0x99F94327)],
//                 colors: [Color(0x99E1DADA), Color(0x99BDCAD9)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Align(
//               alignment: Alignment.center,
    // child: Text(
    //   emojiForClassroom[rand.nextInt(9)],
    //   textScaleFactor: 1.6,
    // ),
//             ),
//           ),
//           SizedBox(width: 6),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   classroom.title,
//                   style: Theme.of(context).textTheme.caption,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '${asanasCount(classroom.classroomRoutines.length)}'
//                       ' • ${classroomTimeRounded(classroom.totalDuration)}',
//                       maxLines: 1,
//                       style: Styles.classroomInfoText,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .39,
      child: Observer(
        builder: (_) {
          final store = Provider.of<ClassroomsStore>(context, listen: false);
          final reversedClassrooms =
              store.usersClassrooms.reversed.toList(growable: false);

          return Scrollbar(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reversedClassrooms.length,
                itemBuilder: (_, index) {
                  final classroom = reversedClassrooms[
                      index]; // FIXME: Possible out of a range

                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          // TODO: Add confirmDismiss with popup
                          store.deleteClassroom(classroom);
                        },
                        background: Container(
                          padding: EdgeInsets.only(right: 20),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            color: Colors.red[200],
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        child: _classroomListItem(classroom, context),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ClassroomScreen(classroom: classroom);
                        },
                      ));
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CreateClass extends StatelessWidget {
  void _onCreateButtonTap(BuildContext context) {
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        final newClassroomStore = NewClassroomStore();

        when(
          (_) => newClassroomStore.editableClassroom != null,
          () {
            Provider.of<ClassroomsStore>(context, listen: false)
                .addClassroom(newClassroomStore.editableClassroom);

            LocalNotification.success(
              context,
              message: 'Class was created',
              inPostCallback: true,
            );
          },
          onError: (error, _) {
            LocalNotification.error(context, inPostCallback: true);
            Log.error(error);
          },
        );

        return NewClassroomScreen(newClassroomStore: newClassroomStore);
      },
    );

    Navigator.push(context, route);
    //.then((v) => print(v));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .08,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onCreateButtonTap(context),
      ),
    );
  }
}
