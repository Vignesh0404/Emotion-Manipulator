import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

//two_pi = 3.14 * 2
class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 4),
              builder: (context, value, child) {
                int percentage = (value * 100).ceil();
                return Container(
                  width: 110,
                  height: 110,
                  //color: Color(0xA60D79DD),
                  child: Stack(
                    children: <Widget>[
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                              startAngle: 0.0,
                              endAngle: 3.14 * 2,
                              stops: [value, value],
                              center: Alignment.center,
                              colors: [
                                Color(0xA60D79DD),
                                Colors.grey.withAlpha(55)
                              ]).createShader(rect);
                        },
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      Image.asset('assets/loading.png').image)),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '$percentage' + '%',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
