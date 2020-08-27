import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPatient extends StatefulWidget {
  final File getImage;
  const AddPatient({Key key, @required this.getImage}) : super(key: key);

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  String name = '';
  String age = '';
  String phnum = '';
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        this.uid = uid;
      });
    });
  }

  void _addData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('Patient');
      await reference
          .add({"name": name, "age": age, "phnum": phnum, "uid": uid});
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
        //backgroundColor: Colors.transparent,
        body: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                //color: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(widget.getImage),
                                fit: BoxFit.cover),
                            border: Border.all(
                                color: index % 2 == 0
                                    ? Colors.black
                                    : Color(0xFF6F6FA8),
                                width: 2.0)),
                      );
                    }),
              ),
              SizedBox(height: 25.0),
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                                //border: Border.all(width: 1),
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xFFF3F3F7),
                                      offset: Offset(0.0, 3))
                                ])),
                      ),
                      Container(
                        alignment: FractionalOffset.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Text(
                            'Add Patient Info',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 75),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                onChanged: (String str) {
                                  setState(() {
                                    name = str;
                                  });
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.account_circle,
                                        color: Color(0xAF030318)),
                                    hintText: "Patient's full name",
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
                              TextField(
                                onChanged: (String str) {
                                  setState(() {
                                    age = str;
                                  });
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.details,
                                        color: Color(0xAF030318)),
                                    hintText: "Patient's age",
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
                              TextField(
                                onChanged: (String str) {
                                  setState(() {
                                    phnum = str;
                                  });
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone,
                                        color: Color(0xAF030318)),
                                    hintText: "Patient's phone number",
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                width: 300,
                                child: FlatButton(
                                  onPressed: _addData,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xA6020216),
                                              Color(0xFF02021A),
                                              Color(0xFF010108),
                                            ])),
                                    child: Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                          maxWidth: double.infinity,
                                          minHeight: 50),
                                      child: Text(
                                        "Submit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ]));
  }
}
