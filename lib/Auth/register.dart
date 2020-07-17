import 'package:YogaAsana/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/auth.dart';

class Register extends StatefulWidget {
  // final List<CameraDescription> cameras;

  // const Register({this.cameras});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _pwdInputController;
  TextEditingController _confirmPwdInputController;

  @override
  initState() {
    _firstNameInputController = TextEditingController();
    _lastNameInputController = TextEditingController();
    _emailInputController = TextEditingController();
    _pwdInputController = TextEditingController();
    _confirmPwdInputController = TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (value.length == 0) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length == 0) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
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
                    Colors.pink,
                    Colors.yellow,
                  ]),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
                          child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 15.0),
                    child: Text("Register", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Signatra",)),
                  ),
                  // Image.asset("assets/images/1.png", height: 100.0,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            // First Name Input
                            TextFormField(
                              controller: _firstNameInputController,
                              decoration: InputDecoration(
                                labelText: "First Name",
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

                            SizedBox(
                              height: 20.0,
                            ),

                            // Last Name Input
                            TextFormField(
                              controller: _lastNameInputController,
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                // hintText: "Doe",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(25.0), // #7449D1
                                ),
                              ),
                              validator: (val) {
                                if (val.length < 3) {
                                  return "Please Enter a valid last name!";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            SizedBox(
                              height: 20.0,
                            ),

                            // Email Input
                            TextFormField(
                              controller: _emailInputController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "example@gmail.com",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(25.0), // #7449D1
                                ),
                              ),
                              validator: emailValidator,
                            ),

                            SizedBox(
                              height: 20.0,
                            ),

                            // Password Input
                            TextFormField(
                              controller: _pwdInputController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "********",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(25.0), // #7449D1
                                ),
                              ),
                              validator: pwdValidator,
                            ),

                            SizedBox(
                              height: 20.0,
                            ),

                            // Confirm Password Input
                            TextFormField(
                              controller: _confirmPwdInputController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                hintText: "********",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(25.0), // #7449D1
                                ),
                              ),
                              validator: pwdValidator,
                            ),

                            SizedBox(
                              height: 32.0,
                            ),

                            // Button
                            Center(
                              child: ButtonTheme(
                                minWidth: 150.0,
                                child: FlatButton(
                                  onPressed: _register,
                                  color: Colors.pink,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            // Sign in here
                            Center(
                              child: FlatButton(
                                color: Colors.transparent,
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Already have an account?\nSign in here',
                                  
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    if (_registerFormKey.currentState.validate()) {
      if (_pwdInputController.text == _confirmPwdInputController.text) {
        Auth auth = Auth();
        FirebaseUser user = await auth
            .signUp(
          _emailInputController.text,
          _pwdInputController.text,
          _firstNameInputController.text,
          _lastNameInputController.text,
        )
            .catchError((err) {
          print(err);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("This email is already registered!"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });

        if (user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                // email: user.email,
                // uid: user.uid,
                // displayName: user.displayName,
                // photoUrl: user.photoUrl,
                // cameras: widget.cameras,
              ),
            ),
            ModalRoute.withName('/login'),
          );
        }

        _firstNameInputController.clear();
        _lastNameInputController.clear();
        _emailInputController.clear();
        _pwdInputController.clear();
        _confirmPwdInputController.clear();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("The passwords do not match"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close"),
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
  }
}
