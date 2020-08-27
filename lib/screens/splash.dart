import 'package:dentalRnD/auth/loginpage.dart';
import 'package:dentalRnD/widgets/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(
        const Duration(seconds: 6),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Root())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Center(
                child: SvgPicture.asset('assets/sample_logo.svg'),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Text(
                'DENTAL RnD',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
