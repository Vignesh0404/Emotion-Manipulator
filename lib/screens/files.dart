import 'dart:io';

import 'package:dentalRnD/screens/patientDetails.dart';
import 'package:dentalRnD/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Files extends StatefulWidget {
  Files({Key key}) : super(key: key);

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  String email;
  String uid;
  File _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        this.email = value.email;
        this.uid = value.uid;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.cloud_download,
                color: Color(0xFF6F6FA8),
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    "Search Patients",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        fontSize: 30),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 150,
                      //color: Colors.orange,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Search here',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  StreamBuilder(
                      stream:
                          Firestore.instance.collection("Patient").snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return new Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                        return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: new PatientsList(
                              document: snapshot.data.documents),
                        );
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PatientsList extends StatelessWidget {
  const PatientsList({Key key, this.document}) : super(key: key);
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 700,
            child: ListView.builder(
                itemCount: document.length,
                itemBuilder: (BuildContext context, int i) {
                  String name = document[i].data['name'].toString();
                  String id = document[i].data['id'].toString();
                  String image = document[i].data['image'].toString();
                  String timestamp = document[i].data['timestamp'].toString();
                  String rms = document[i].data['rms'].toString();
                  String age = document[i].data['age'].toString();
                  String phnum = document[i].data['phnum'].toString();
                  //print(name);
                  return Dismissible(
                    key: new Key(document[i].documentID),
                    background: Container(color: Colors.red[100]),
                    onDismissed: (direction) {
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(document[i].reference);
                        await transaction.delete(snapshot.reference);
                      });

                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Patient Data Deleted"),
                        backgroundColor: Colors.black,
                      ));
                    },
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => PatientDetails(
                                  name: name,
                                  age: age,
                                  index: document[i].reference,
                                  //phnum: ,
                                )));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 0, bottom: 10, top: 15, left: 0),
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //border: Border.all(width: 2),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/home1.png',
                              ),
                              minRadius: 40,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: 100,
                              width: 3,
                              color: i % 2 == 0
                                  ? Colors.lightBlue
                                  : Colors.lightGreen,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Patient's Name: ",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                    Text(name)
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Phone Num: ",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12),
                                      ),
                                      Text(phnum),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Appoinment Date :",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "21/07/20",
                                      overflow: TextOverflow.fade,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
