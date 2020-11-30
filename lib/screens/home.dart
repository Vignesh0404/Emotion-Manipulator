import 'package:dentalRnD/screens/blogDetails.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        resizeToAvoidBottomPadding: false,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        "- RMS-DAS, - FIS \n- RMS PS, - VPT Scale\n- Retest RMS-DAS",
                        style: TextStyle(
                          letterSpacing: 2,
                          wordSpacing: 2,
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
                              launch(
                                  'http://www.jisppd.com/article.asp?issn=0970-4388;year=2015;volume=33;issue=1;spage=48;epage=52;aulast=shetty');
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
                padding: const EdgeInsets.only(left: 13.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('About the Scales',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                )),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('RMS DIGITAL ANXIETY SCALE (RMS-DAS)',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Comparison with',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('RMS PS',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  Text('FIS',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  Text('VPT SCALE',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  Text('Retest of RMS Digital Anxiety Scale (RMS-DAS)',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  SizedBox(
                    height: 20,
                  ),
                  Text('RMS DIGITAL CHILDREN DENTAL ANXIETY SCALE (RMS-DCDAS)',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Comparison with',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('RMS - DCDAS',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  Text('MCDAS',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                  Text('RMS - DCDAS',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14)),
                ],
              ),
            )
          ],
        ));
  }
}
