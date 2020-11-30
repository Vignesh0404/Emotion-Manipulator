import 'dart:io';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientDetails extends StatefulWidget {
  PatientDetails(
      {Key key,
      this.age,
      this.name,
      this.phnum,
      this.img,
      this.index,
      this.date,
      this.time,
      this.rmsBS,
      this.rmsDS,
      this.rmsPsg,
      this.fis,
      this.vpt,
      this.rmsPS,
      this.id,
      this.appNo,
      this.address,
      this.gender})
      : super(key: key);
  final String name;
  final String age;
  final String phnum;
  final String date;
  final String time;
  final String img;
  final String id;
  final String appNo;
  final String address;
  final String gender;
  final String rmsDS;
  final String vpt;
  final String fis;
  final String rmsBS;
  final String rmsPS;
  final String rmsPsg;
  final index;

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  TextEditingController controllerName;
  TextEditingController controllerAge;
  TextEditingController controllerPhnum;

  String name;
  String age;
  String phnum;
  String uid;

  void updatePatientData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "name": name,
        "age": age,
        "phnum": phnum,
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        this.uid = value.uid;
        print(uid);
      });
    }).catchError((err) {
      print(err);
    });
    name = widget.name;
    age = widget.age;
    phnum = widget.phnum;

    controllerName = new TextEditingController(text: widget.name);
    controllerAge = new TextEditingController(text: widget.age);
    controllerPhnum = new TextEditingController(text: widget.phnum);
  }

  @override
  Widget build(BuildContext context) {
    var children = List<Widget>();
    children.add(
      FloatingActionRowButton(
        icon: Icon(Icons.edit),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return SingleChildScrollView(
                  child: Container(
                      height: 600,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Edit Patient Details ",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                //color: Colors.red[300],
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                    controller: controllerName,
                                    onChanged: (String str) {
                                      setState(() {
                                        name = str;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lightbulb_outline),
                                        hintText: "Name",
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black)),
                                TextField(
                                    controller: controllerAge,
                                    onChanged: (String str) {
                                      setState(() {
                                        age = str;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.assignment),
                                        hintText: "Age",
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black)),
                                TextField(
                                    controller: controllerPhnum,
                                    onChanged: (String str) {
                                      phnum = str;
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.phone),
                                        hintText: "Phone Number",
                                        border: InputBorder.none),
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                              onPressed: updatePatientData,
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                //color: Colors.black,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text("                                  "),
                                    Text(
                                      "Edit Now   ",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )),
                );
              });
        },
      ),
    );
    children.add(
      FloatingActionRowDivider(),
    );
    children.add(
      FloatingActionRowButton(
        icon: Icon(Icons.delete),
        onTap: () {
          Firestore.instance.runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(widget.index);
            await transaction.delete(snapshot.reference);
          });
          Navigator.pop(context);
        },
      ),
    );
    children.add(
      FloatingActionRowDivider(),
    );

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
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
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionRow(
              children: children,
              color: Color(0xA60D79DD),
              elevation: 3,
            ),
            body: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 170.0,
                    height: 170.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.img),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '#' +
                                widget.id +
                                "  " +
                                widget.name +
                                ",  " +
                                widget.age,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Color(0xA60D79DD),
                                size: 24,
                              ),
                              Text(
                                ' ' + widget.address,
                                style: TextStyle(fontFamily: 'Poppins'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '  ' +
                                widget.phnum +
                                ',  Appointment Num: ' +
                                widget.appNo,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 7),
                          Text(
                            '  ' + widget.date + ',  ' + widget.time,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'About,',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'RMS Digital Scale: ' + widget.rmsDS + ' ,    ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                'RMS PS Scale(boys): ' + widget.rmsPS + ' ,',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'RMS PS Scale(girls): ' +
                                    widget.rmsPsg +
                                    '  , ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // Text(
                              //   'RMS Blind Scale: ' + widget.rmsBS + '  ,',
                              //   style: TextStyle(
                              //     fontFamily: 'Poppins',
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'VPT Scale: ' + widget.vpt + ' ,    ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                'FIS Scale: ' + widget.fis + ' ,',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 35),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            width: 300,
                            child: FlatButton(
                              onPressed: () {},
                              child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xA60D79DD),
                                          Color(0xA60D79DD),
                                          Color(0xFF1C63A1),
                                        ])),
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(
                                      maxWidth: double.infinity, minHeight: 50),
                                  child: Text(
                                    "Retest RMS - DAS",
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
                          ),
                        ],
                      ),
                    ),
                  )
                ])));
  }
}
