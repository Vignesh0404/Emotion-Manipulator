import 'package:dentalRnD/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functionPicker.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void signOut() async {
    try {
      // await GoogleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      //await _googleSignInInstance.signOut();
    } catch (e) {
      print(e);
    }
  }

  TextEditingController password = new TextEditingController();
  String uid;
  String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.email = val.email;
        this.uid = val.uid;
        print(email);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void dialogBox(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '                Coming Soon!',
                          hintStyle: TextStyle(fontFamily: 'Poppins')),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // resizeToAvoidBottomPadding: false,
          body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      email == null
                          ? Text('error')
                          : Text(
                              email,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      height: 500,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Change Password',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: password,
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                    hintText: 'Change Password',
                                                    border: InputBorder.none,
                                                    icon: Icon(
                                                      Icons.security,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                FlatButton(
                                                    onPressed: () async {
                                                      try {
                                                        FirebaseUser user =
                                                            (await FirebaseAuth
                                                                    .instance
                                                                    .confirmPasswordReset(
                                                                        'https://hotlunch-d92b1.firebaseapp.com/__/auth/action?mode=<action>&oobCode=<code>',
                                                                        password
                                                                            .text))
                                                                as FirebaseUser;
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Dialog(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  height: 80,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        TextField(
                                                                          decoration: InputDecoration(
                                                                              border: InputBorder.none,
                                                                              hintText: ' Your password is changed! ',
                                                                              hintStyle: TextStyle(fontFamily: 'Poppins')),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      } catch (e) {
                                                        print('Error: $e');
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Text(
                                                                    'This is the password currently been used'),
                                                              );
                                                            });
                                                      }
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 40,
                                                      //color: Colors.black,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                              "                                  "),
                                                          Text(
                                                            "Update   ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Icon(
                                                            Icons.arrow_forward,
                                                            color: Colors.white,
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          })
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                //border: Border.all(width: 1),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Icon(
                    Icons.chat,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        dialogBox(context);
                      },
                      child: Text(
                        'Help Center',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: 280,
                      color: Colors.grey.shade500,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Icon(
                    Icons.info,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        dialogBox(context);
                      },
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: 280,
                      color: Colors.grey.shade500,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Icon(
                    Icons.mail_outline,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        dialogBox(context);
                      },
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: 280,
                      color: Colors.grey.shade500,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FunctionPicker()));
                      },
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: 280,
                      color: Colors.grey.shade500,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Icon(
                    Icons.star,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        dialogBox(context);
                      },
                      child: Text(
                        'Rate Us',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: 280,
                      color: Colors.grey.shade500,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
            FlatButton(
              onPressed: () async {
                signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('isLoggedIn');
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage()));
              },
              child: Text('Logout',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              height: 22,
              width: 40,
              //color: Colors.orange,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: Text(
                '  v1.0',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            )
          ],
        ),
      )),
    );
  }
}

/* 

 Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(uid),
                Text(email),
                ListTile(
                    title: Text("Log Out",
                        style: TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    subtitle: Text("Tap here to log out",
                        style: TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700)),
                    trailing: Icon(
                      Icons.settings_power,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      //await prefs.setBool('seen1', false);
                      //prefs.remove('seen1');
                      //prefs.remove('seenkid');

                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new LoginPage()));
                    })
              ],
            ),
          )
        ],
      )
*/
