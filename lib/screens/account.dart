import 'package:dentalRnD/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          body: Column(
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
      )),
    );
  }
}
