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
        backgroundColor: Color(0xA60D79DD),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Center(
                child: SvgPicture.asset('assets/sample_logo1.svg'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'RMS DIGITAL SCALE',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
            ),
            SizedBox(
              height: 240,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'from',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                  Text(
                    'Dr. Shetty',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
