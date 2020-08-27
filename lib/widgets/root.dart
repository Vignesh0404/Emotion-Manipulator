import 'dart:async';

import 'package:dentalRnD/auth/loginpage.dart';
import 'package:dentalRnD/screens/onBoarding.dart';
import 'package:dentalRnD/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  Future checkFirstScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _seen = (preferences.getBool('seen') ?? false);
    print(_seen);
    if (_seen) {
      navigateUser();
    } else {
      await preferences.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 175), () {
      checkFirstScreen();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => Navigation()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
