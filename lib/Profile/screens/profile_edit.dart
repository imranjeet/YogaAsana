import 'dart:io';
import 'package:YogaAsana/Auth/login.dart';
import 'package:YogaAsana/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../util/constant.dart';
import '../../util/auth.dart';

class ProfileEdit extends StatefulWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;

  ProfileEdit({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
  });

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _displayNameController;

  String _titleText;
  String _displayName;
  String _photoUrl;
  File _image;

  @override
  void initState() {
    _displayNameController = TextEditingController(
      text: widget.displayName,
    );

    _titleText = 'Profile';

    // _displayName = widget.displayName;
    // _photoUrl = widget.photoUrl;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.redAccent,
                    Colors.yellowAccent,
                  ]),
              //   image: DecorationImage(
              //     alignment: Alignment.centerLeft,
              //     image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              //   ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: InkWell(
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.exit_to_app,
                    //     size: 30,
                    //   ),
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
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28.0, 13.0, 28.0, 20),
                    child: SingleChildScrollView(
                      child: Container(
                        // height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                    ),
                                  ]),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: 'profile',
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: _image == null
                                          ? AssetImage(
                                              'assets/images/profile-image.png',
                                            )
                                          : FileImage(_image),
                                      // : _image == null
                                      //     ? AssetImage(
                                      //         'assets/images/profile-image.png',
                                      //       )
                                      //     : FileImage(_image),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0.0,
                                    bottom: 0.0,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        // color: Colors.blueGrey[100],
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: FloatingActionButton(
                                        // heroTag: null,
                                        elevation: 2.0,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                        onPressed: _getImage,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),

                            Container(
                              padding: EdgeInsets.only(top: 30),
                              width: size.width * .75,
                              child: TextFormField(
                                controller: _displayNameController,
                                decoration: InputDecoration(
                                  labelText: "Your Name",
                                  // hintText: "John",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(25.0), // #7449D1
                                  ),
                                ),
                                validator: (val) {
                                  if (val.length < 3) {
                                    return "Please Enter a valid first name!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            SizedBox(
                              height: size.height * .05,
                            ),

                            RaisedButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () async {
                                Auth auth = Auth();
                                await auth.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(
                                      // cameras: cameras,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Update",
                                style: kTitleTextstyle,
                              ),
                            ),

                            SizedBox(
                              height: size.height * .1,
                            ),

                            RaisedButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () => _onConfirmUpdate(
                                displayName: _displayNameController.text,
                                photo: _image,
                              ),
                              child: Text(
                                "Sign Out",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),

                            // Level
                            // CircularPercentIndicator(
                            //   radius: 120.0,
                            //   lineWidth: 13.0,
                            //   animation: true,
                            //   animationDuration: 600,
                            //   percent: 0.7,
                            //   circularStrokeCap: CircularStrokeCap.round,
                            //   progressColor: Colors.indigo[400],
                            //   center: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       Text(
                            //         "Level",
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 16.0,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 5,
                            //       ),
                            //       Text(
                            //         "40",
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 26.0,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getPhotoUrl(File photo) async {
    Auth auth = Auth();
    if (photo != null) {
      String photoUrl = await auth.storeProfilePhoto(photo);
      _photoUrl = photoUrl;
    }
  }

  void _onConfirmUpdate({
    String displayName,
    File photo,
  }) async {
    // _progressBarActive = true;
    Auth auth = Auth();
    var user = await auth.getCurrentUser();
    print(user);

    if (photo != null) await _getPhotoUrl(photo);

    var updatedUser = await auth.updateCurrentUser(
      displayName: displayName ?? displayName,
      photoUrl: _photoUrl ?? _photoUrl,
    );
    print(updatedUser.displayName);
    print(updatedUser.photoUrl);
    // _progressBarActive = false;

    setState(() {
      if (!mounted) {
        return;
      }
      // _editMode = !_editMode;
      _displayName = updatedUser.displayName;
      _photoUrl = updatedUser.photoUrl;
      _titleText = 'Profile';
      Navigator.pop(context);
    });
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 100,
      maxWidth: 100,
    );
    print(image.toString());

    setState(() {
      if (!mounted) {
        return;
      }
      _image = image;
    });

    // File croppedImage = await ImageCropper.cropImage(
    //   sourcePath: _image.path,
    //   aspectRatio: CropAspectRatio(
    //     ratioX: 1,
    //     ratioY: 1,
    //   ),
    //   // aspectRatioPresets: [
    //   //   CropAspectRatioPreset.square,
    //   // ],
    //   androidUiSettings: AndroidUiSettings(
    //     toolbarTitle: 'Image Cropper',
    //     toolbarColor: Colors.black,
    //     toolbarWidgetColor: Colors.white,
    //     initAspectRatio: CropAspectRatioPreset.square,
    //     lockAspectRatio: true,
    //   ),
    //   // iosUiSettings: IOSUiSettings(
    //   //   minimumAspectRatio: 1.0,
    //   // ),
    // );

    // print(croppedImage.toString());

    // setState(() {
    //   _image = croppedImage ?? _image;
    // });
  }
}
