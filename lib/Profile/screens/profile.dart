import 'dart:io';
import 'package:YogaAsana/Auth/login.dart';
import 'package:YogaAsana/Class/stores/asanas_store.dart';
import 'package:YogaAsana/Class/stores/classrooms_store.dart';
import 'package:YogaAsana/Class/utils/local_notification.dart';
import 'package:YogaAsana/Profile/screens/profile_edit.dart';
import 'package:YogaAsana/util/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../../util/constant.dart';
import '../../util/auth.dart';

class Profile extends StatefulWidget {
  // final String email;
  // final String uid;
  // final String displayName;
  // final String photoUrl;

  // Profile({
  //   this.email,
  //   this.uid,
  //   this.displayName,
  //   this.photoUrl,
  // });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // bool _progressBarActive = false;
  bool _isCleaning = false;

  // bool _editMode = false;
  // TextEditingController _displayNameController;
  // String _titleText;
  // String _displayName;
  // String _photoUrl;
  // File _image;

  // @override
  // void initState() {
  //   _displayNameController = TextEditingController(
  //     text: widget.displayName,
  //   );

  //   _titleText = 'Profile';

  //   _displayName = widget.displayName;
  //   _photoUrl = widget.photoUrl;

  //   super.initState();
  // }

  void _clearAndRefresh(BuildContext context) async {
    setState(() => _isCleaning = true);

    try {
      final asanasStore = Provider.of<AsanasStore>(context, listen: false);
      final classroomsStore =
          Provider.of<ClassroomsStore>(context, listen: false);

      await asanasStore.refreshData();
      await classroomsStore.refreshData();

      _showNotification(context);
    } catch (_) {
      _showNotification(context, isError: true);
    } finally {
      setState(() => _isCleaning = false);
    }
  }

  void _showNotification(BuildContext context, {bool isError = false}) {
    if (isError == false) {
      LocalNotification.success(context,
          message: 'Data was flushed successful');
    } else {
      LocalNotification.error(context);
    }
  }

  void _onClearButtonTap(BuildContext context) {
    // TODO: Pick up to separate widget with platform selecting logic
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Text('Are you sure, you want to delete all users data?'),
          actions: [
            FlatButton(
                child: Text('Cancel'),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text('Delete'),
                textColor: Colors.red[400],
                onPressed: () {
                  Navigator.of(context).pop();
                  _clearAndRefresh(context);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // User user = User();
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
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 30,
                  ),
                  onPressed: (){},
                  // onPressed: () async {
                  //   Auth auth = Auth();
                  //   await auth.signOut();
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Login(
                  //           // cameras: cameras,
                  //           ),
                  //     ),
                  //   );
                  // },
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * .78,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28.0, 13.0, 28.0, 20),
                  child: SingleChildScrollView(
                    child: Container(
                      // height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70.0),
                                border: Border.all(
                                  color: Colors.blueGrey[100],
                                  width: 3,
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
                                      radius: 60,
                                      backgroundImage: AssetImage("assets/images/1.png"),
                                      // backgroundImage: user.photoUrl == null
                                      //     ? AssetImage(
                                      //         'assets/images/profile-image.png',
                                      //       )
                                      //     : NetworkImage(
                                      //         user.photoUrl,
                                      //       )
                                      // : _image == null
                                      //     ? AssetImage(
                                      //         'assets/images/profile-image.png',
                                      //       )
                                      //     : FileImage(_image),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),

                          Text(
                            "YogaAsana",
                            // user.displayName,
                            style: kHeadingTextStyle,
                          ),

                          SizedBox(
                            height: size.height * .05,
                          ),

                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.info,
                                color: Colors.black,
                                size: 30,
                              ),
                              title: Text("About"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onTap: () {
                                _showAboutDialog();
                              },
                              // onTap: () => Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ProfileEdit(
                              //               email: user.email,
                              //               uid: user.uid,
                              //               displayName: user.displayName,
                              //               photoUrl: user.photoUrl,
                              //             ))),
                            ),
                          ),

                          SizedBox(
                            height: size.height * .02,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.verified_user,
                                color: Colors.black,
                                size: 30,
                              ),
                              title: Text("Terms & Conditions"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onTap: () {
                                _showTermsDialog(
                                  context,
                                  "Terms & Conditions",
                                );
                              },
                            ),
                          ),

                          SizedBox(
                            height: size.height * .02,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.security,
                                color: Colors.black,
                                size: 30,
                              ),
                              title: Text("Privacy Policy"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onTap: () {
                                _showPrivacyDialog(context, "Privacy Policy");
                              },
                            ),
                          ),

                          SizedBox(
                            height: size.height * .02,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.delete,
                                color: Colors.black,
                                size: 30,
                              ),
                              title: Text("Clear cache data"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onTap: _isCleaning
                                  ? null
                                  : () => _onClearButtonTap(context),
                            ),
                          ),

                          SizedBox(
                            height: size.height * .05,
                          ),

                          Text(
                            "v1.0.0",
                            style: TextStyle(fontSize: 20),
                          ),

                          // RaisedButton(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 50, vertical: 5),
                          //     // color: Colors.red[300],

                          //     shape: RoundedRectangleBorder(
                          //       side:
                          //           BorderSide(color: Colors.white70, width: 1),
                          //       borderRadius: BorderRadius.circular(20),
                          //     ),
                          //     onPressed: () => Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => ProfileEdit(
                          //                   email: user.email,
                          //                   uid: user.uid,
                          //                   displayName: user.displayName,
                          //                   photoUrl: user.photoUrl,
                          //                 ))),
                          //     child: Text(
                          //       "Edit",
                          //       style: kHeadingTextStyle,
                          //     )),

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

                          // Streak
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     Text(
                          //       'Streak: ',
                          //       style: TextStyle(fontSize: 20.0),
                          //     ),
                          //     Text(
                          //       '30',
                          //       style: TextStyle(fontSize: 20.0),
                          //     ),
                          //   ],
                          // ),

                          // Bottom Options
                          // Divider(
                          //   color: Colors.blueGrey[500],
                          //   indent: 24.0,
                          //   endIndent: 24.0,
                          //   thickness: 1.0,
                          // ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: <Widget>[],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Avatar
            ],
          ),
        ),
      ],
    );
  }

  _showAboutDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("YogaAsana"),
          content: new Text("Version: v1.0.0"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showTermsDialog(
    BuildContext context,
    String title,
  ) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Scaffold(
            body: Scrollbar(
              child: SingleChildScrollView(
                child: Html(data: """ <!DOCTYPE html>
                    <html>
                    
                    <body>
                     <p>
                      By downloading or using the app, these terms will
                      automatically apply to you – you should make sure therefore
                      that you read them carefully before using the app. You’re not
                      allowed to copy, or modify the app, any part of the app, or
                      our trademarks in any way. You’re not allowed to attempt to
                      extract the source code of the app, and you also shouldn’t try
                      to translate the app into other languages, or make derivative
                      versions. The app itself, and all the trade marks, copyright,
                      database rights and other intellectual property rights related
                      to it, still belong to Ranjeet Kumar.
                    </p> <p>
                      Ranjeet Kumar is committed to ensuring that the app is
                      as useful and efficient as possible. For that reason, we
                      reserve the right to make changes to the app or to charge for
                      its services, at any time and for any reason. We will never
                      charge you for the app or its services without making it very
                      clear to you exactly what you’re paying for.
                    </p> <p>
                      The YogaAsana app stores and processes personal data that
                      you have provided to us, in order to provide my
                      Service. It’s your responsibility to keep your phone and
                      access to the app secure. We therefore recommend that you do
                      not jailbreak or root your phone, which is the process of
                      removing software restrictions and limitations imposed by the
                      official operating system of your device. It could make your
                      phone vulnerable to malware/viruses/malicious programs,
                      compromise your phone’s security features and it could mean
                      that the YogaAsana app won’t work properly or at all.
                    </p> <div><p>
                        The app does use third party services that declare their own
                        Terms and Conditions.
                      </p> <p>
                        Link to Terms and Conditions of third party service
                        providers used by the app
                      </p> <ul><li><a href="https://policies.google.com/terms" target="_blank" rel="noopener noreferrer">Google Play Services</a></li><!----><li><a href="https://firebase.google.com/terms/analytics" target="_blank" rel="noopener noreferrer">Google Analytics for Firebase</a></li><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----></ul></div> <p>
                      You should be aware that there are certain things that
                      Ranjeet Kumar will not take responsibility for. Certain
                      functions of the app will require the app to have an active
                      internet connection. The connection can be Wi-Fi, or provided
                      by your mobile network provider, but Ranjeet Kumar
                      cannot take responsibility for the app not working at full
                      functionality if you don’t have access to Wi-Fi, and you don’t
                      have any of your data allowance left.
                    </p> <p></p> <p>
                      If you’re using the app outside of an area with Wi-Fi, you
                      should remember that your terms of the agreement with your
                      mobile network provider will still apply. As a result, you may
                      be charged by your mobile provider for the cost of data for
                      the duration of the connection while accessing the app, or
                      other third party charges. In using the app, you’re accepting
                      responsibility for any such charges, including roaming data
                      charges if you use the app outside of your home territory
                      (i.e. region or country) without turning off data roaming. If
                      you are not the bill payer for the device on which you’re
                      using the app, please be aware that we assume that you have
                      received permission from the bill payer for using the app.
                    </p> <p>
                      Along the same lines, Ranjeet Kumar cannot always take
                      responsibility for the way you use the app i.e. You need to
                      make sure that your device stays charged – if it runs out of
                      battery and you can’t turn it on to avail the Service,
                      Ranjeet Kumar cannot accept responsibility.
                    </p> <p>
                      With respect to Ranjeet Kumar’s responsibility for your
                      use of the app, when you’re using the app, it’s important to
                      bear in mind that although we endeavour to ensure that it is
                      updated and correct at all times, we do rely on third parties
                      to provide information to us so that we can make it available
                      to you. Ranjeet Kumar accepts no liability for any
                      loss, direct or indirect, you experience as a result of
                      relying wholly on this functionality of the app.
                    </p> <p>
                      At some point, we may wish to update the app. The app is
                      currently available on Android – the requirements for
                      system(and for any additional systems we
                      decide to extend the availability of the app to) may change,
                      and you’ll need to download the updates if you want to keep
                      using the app. Ranjeet Kumar does not promise that it
                      will always update the app so that it is relevant to you
                      and/or works with the Android version that you have
                      installed on your device. However, you promise to always
                      accept updates to the application when offered to you, We may
                      also wish to stop providing the app, and may terminate use of
                      it at any time without giving notice of termination to you.
                      Unless we tell you otherwise, upon any termination, (a) the
                      rights and licenses granted to you in these terms will end;
                      (b) you must stop using the app, and (if needed) delete it
                      from your device.
                    </p> <p><strong>Changes to This Terms and Conditions</strong></p> <p>
                      I may update our Terms and Conditions
                      from time to time. Thus, you are advised to review this page
                      periodically for any changes. I will
                      notify you of any changes by posting the new Terms and
                      Conditions on this page.
                    </p> <p>
                      These terms and conditions are effective as of 2020-07-12
                    </p> <p><strong>Contact Us</strong></p> <p>
                      If you have any questions or suggestions about my
                      Terms and Conditions, do not hesitate to contact me
                      at infouslabs@gmail.com.
                    </a></p>
                    </body>
                    </html>
                      """),
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _displayNameWidget(String displayName) {
    return Center(
      child: Container(
        // alignment: Alignment.center,
        // width: 200,
        padding: EdgeInsets.only(top: 10),
        child: Text(
          displayName,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // Widget _editNameWidget() {
  //   return Container(
  //     padding: EdgeInsets.only(top: 10),
  //     width: 200,
  //     child: TextField(
  //       autofocus: true,
  //       style: TextStyle(
  //         fontSize: 25,
  //       ),
  //       controller: _displayNameController,
  //       textAlign: TextAlign.center,
  //       decoration: InputDecoration(),
  //     ),
  //   );
  // }

  // Future<void> _onEdit(BuildContext context) async {
  //   setState(() {
  //     _editMode = !_editMode;
  //     _titleText = 'Update Profile';
  //   });
  // }

  // Future<void> _getPhotoUrl(File photo) async {
  //   Auth auth = Auth();
  //   if (photo != null) {
  //     String photoUrl = await auth.storeProfilePhoto(photo);
  //     _photoUrl = photoUrl;
  //   }
  // }

  _showPrivacyDialog(
    BuildContext context,
    String title,
  ) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Scaffold(
            body: Scrollbar(
              child: SingleChildScrollView(
                child: Html(data: """ <!DOCTYPE html>
                  <html>
                  
                  <body>
                  <p>
                  Ranjeet Kumar built the YogaAsana app as
                  a Free app. This SERVICE is provided by
                  Ranjeet Kumar at no cost and is intended for use as
                  is.
                </p> <p>
                  This page is used to inform visitors regarding my
                  policies with the collection, use, and disclosure of Personal
                  Information if anyone decided to use my Service.
                </p> <p>
                  If you choose to use my Service, then you agree to
                  the collection and use of information in relation to this
                  policy. The Personal Information that I collect is
                  used for providing and improving the Service. I will not use or share your information with
                  anyone except as described in this Privacy Policy.
                </p> <p>
                  The terms used in this Privacy Policy have the same meanings
                  as in our Terms and Conditions, which is accessible at
                  YogaAsana unless otherwise defined in this Privacy Policy.
                </p> <p><strong>Information Collection and Use</strong></p> <p>
                  For a better experience, while using our Service, I
                  may require you to provide us with certain personally
                  identifiable information, including but not limited to email, name and user image. The information that
                  I request will be retained on your device and is not collected by me in any way.
                </p> <div><p>
                    The app does use third party services that may collect
                    information used to identify you.
                  </p> <p>
                    Link to privacy policy of third party service providers used
                    by the app
                  </p> <ul><li><a href="https://www.google.com/policies/privacy/" target="_blank" rel="noopener noreferrer">Google Play Services</a></li><!----><li><a href="https://firebase.google.com/policies/analytics" target="_blank" rel="noopener noreferrer">Google Analytics for Firebase</a></li><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----><!----></ul></div> <p><strong>Log Data</strong></p> <p>
                  I want to inform you that whenever you
                  use my Service, in a case of an error in the app
                  I collect data and information (through third party
                  products) on your phone called Log Data. This Log Data may
                  include information such as your device Internet Protocol
                  (“IP”) address, device name, operating system version, the
                  configuration of the app when utilizing my Service,
                  the time and date of your use of the Service, and other
                  statistics.
                </p> <p><strong>Cookies</strong></p> <p>
                  Cookies are files with a small amount of data that are
                  commonly used as anonymous unique identifiers. These are sent
                  to your browser from the websites that you visit and are
                  stored on your device's internal memory.
                </p> <p>
                  This Service does not use these “cookies” explicitly. However,
                  the app may use third party code and libraries that use
                  “cookies” to collect information and improve their services.
                  You have the option to either accept or refuse these cookies
                  and know when a cookie is being sent to your device. If you
                  choose to refuse our cookies, you may not be able to use some
                  portions of this Service.
                </p> <p><strong>Service Providers</strong></p> <p>
                  I may employ third-party companies and
                  individuals due to the following reasons:
                </p> <ul><li>To facilitate our Service;</li> <li>To provide the Service on our behalf;</li> <li>To perform Service-related services; or</li> <li>To assist us in analyzing how our Service is used.</li></ul> <p>
                  I want to inform users of this Service
                  that these third parties have access to your Personal
                  Information. The reason is to perform the tasks assigned to
                  them on our behalf. However, they are obligated not to
                  disclose or use the information for any other purpose.
                </p> <p><strong>Security</strong></p> <p>
                  I value your trust in providing us your
                  Personal Information, thus we are striving to use commercially
                  acceptable means of protecting it. But remember that no method
                  of transmission over the internet, or method of electronic
                  storage is 100% secure and reliable, and I cannot
                  guarantee its absolute security.
                </p> <p><strong>Links to Other Sites</strong></p> <p>
                  This Service may contain links to other sites. If you click on
                  a third-party link, you will be directed to that site. Note
                  that these external sites are not operated by me.
                  Therefore, I strongly advise you to review the
                  Privacy Policy of these websites. I have
                  no control over and assume no responsibility for the content,
                  privacy policies, or practices of any third-party sites or
                  services.
                </p> <p><strong>Children’s Privacy</strong></p> <p>
                  These Services do not address anyone under the age of 13.
                  I do not knowingly collect personally
                  identifiable information from children under 13. In the case
                  I discover that a child under 13 has provided
                  me with personal information, I immediately
                  delete this from our servers. If you are a parent or guardian
                  and you are aware that your child has provided us with
                  personal information, please contact me so that
                  I will be able to do necessary actions.
                </p> <p><strong>Changes to This Privacy Policy</strong></p> <p>
                  I may update our Privacy Policy from
                  time to time. Thus, you are advised to review this page
                  periodically for any changes. I will
                  notify you of any changes by posting the new Privacy Policy on
                  this page.
                </p> <p>This policy is effective as of 2020-07-12</p> <p><strong>Contact Us</strong></p> <p>
                  If you have any questions or suggestions about my
                  Privacy Policy, do not hesitate to contact me at infouslabs@gmail.com.
                </a></p>
                  </body>
                  </html>
      
                      """),
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
