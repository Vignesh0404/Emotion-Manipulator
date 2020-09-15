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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      Text(
                        email,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: null)
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text('+918668088824')
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
                    Text(
                      'Help Center',
                      style: TextStyle(
                          fontFamily: 'Poppins', color: Colors.black87),
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
                    Text(
                      'About Us',
                      style: TextStyle(
                          fontFamily: 'Poppins', color: Colors.black87),
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
                    Text(
                      'Contact Us',
                      style: TextStyle(
                          fontFamily: 'Poppins', color: Colors.black87),
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
                    Text(
                      'Rate Us',
                      style: TextStyle(
                          fontFamily: 'Poppins', color: Colors.black87),
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
              onPressed: signOut,
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
