import 'package:dentalRnD/screens/camera.dart';
import 'package:flutter/material.dart';

class LoadingImage extends StatefulWidget {
  LoadingImage({Key key}) : super(key: key);

  @override
  _LoadingImageState createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  @override
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 25),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Camera())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/loader.gif'))),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '        Rendering your ',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xA60D79DD),
                              fontSize: 17),
                        ),
                        Text(
                          'images',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xA646E020),
                              fontSize: 17),
                        ),
                        Text(
                          ' for you',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xA60D79DD),
                              fontSize: 17),
                        ),
                        Text(
                          ' .....',
                          style: TextStyle(
                              letterSpacing: 2,
                              fontFamily: 'Poppins',
                              color: Color(0xA646E020),
                              fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
