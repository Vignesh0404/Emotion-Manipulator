import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Color(0xFF545D68),
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Color(0xFF545D68),
                ),
                onPressed: () {})
          ],
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black45, offset: Offset(0.0, 3))
                      ]),
                ),
                Container(
                  alignment: FractionalOffset.centerRight,
                  child: Image(
                    image: AssetImage('assets/home1.png'),
                    height: 200,
                    width: 190,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 30.0, top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "What do we do?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "lorem pisum asdasda",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 30.0, top: 120.0),
                  child: Container(
                    height: 40.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFCCDDEC),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '   Learn More',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_forward), onPressed: () {})
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
