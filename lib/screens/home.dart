import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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
                          hintText: '       Yay, Patient Data Saved!',
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
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              dialogBox(context);
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Latest Articles',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 130,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      height: 100,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/youtube.jpg'))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 220,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              'Infectional control recommendation for density.',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xA60D79DD),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                                '-----------------------------------------------------------------------------------------------------------------------------.')
                          ],
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 130,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      height: 100,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/youtube.jpg'))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 220,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              'Summary of Infection Prevention Practices in Dental Settings',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xA60D79DD),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                                '--------------------------------------------------------------------------------------.')
                          ],
                        )),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
