import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalRnD/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String address = '';
  String patientid = '';
  String appointmentNum = '';
  String gender = '';
  String rmsDSS = '';
  String rmsPS = '';
  String vpt = '';
  String fis = '';
  String rmsBS = '';
  String uid;
  String email;
  AssetImage sadimg;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        this.uid = value.uid;
        this.email = value.email;
        print(uid);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _addData(BuildContext context) async {
    //String imgName = basename(widget.getImage.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("$email/$name/" + 'input.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget.getImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String url = await taskSnapshot.ref.getDownloadURL();
    String webUrl = url.toString();
    print('the url is $webUrl');

    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d,yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('Patient');
      await reference.add({
        "ID": patientid,
        "app no": appointmentNum,
        "name": name,
        "age": age,
        "address": address,
        "gender": gender,
        "phnum": phnum,
        "rms digital scale": rmsDSS,
        "rms ps scale score": rmsPS,
        "vpt scale score": vpt,
        "fis scale score": fis,
        'rms blind score': rmsBS,
        "uid": uid,
        "url": webUrl,
        //"sadimg": sadimg,
        "date": date,
        "time": time
      });
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Navigation(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
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
        body: SingleChildScrollView(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //sadImg,
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'faceswap/results/' + uid + '_input_sad.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('faceswap/results/' +
                                  uid +
                                  '_input_smile.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('faceswap/results/' +
                                  uid +
                                  '_input_smirk.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('faceswap/results/' +
                                  uid +
                                  '_input_poker.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('faceswap/results/' +
                                  uid +
                                  '_input_sligthlysad.jpg'),
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 650,
                              decoration: BoxDecoration(
                                  //border: Border.all(width: 1),
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Color(0xA60D79DD),
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
                                      patientid = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.account_circle,
                                          color: Color(0xA60D79DD)),
                                      hintText: "PATIENT ID",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      appointmentNum = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.account_circle,
                                          color: Color(0xA60D79DD)),
                                      hintText: "APPOINTMENT NO",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      name = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.account_circle,
                                          color: Color(0xA60D79DD)),
                                      hintText: "FULL NAME",
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
                                          color: Color(0xA60D79DD)),
                                      hintText: "AGE",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      address = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.location_city,
                                          color: Color(0xA60D79DD)),
                                      hintText: "ADDRESS",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      gender = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.account_circle,
                                          color: Color(0xA60D79DD)),
                                      hintText: "GENDER",
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
                                          color: Color(0xA60D79DD)),
                                      hintText: "PHONE NUMBER",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      rmsDSS = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.phone,
                                          color: Color(0xA60D79DD)),
                                      hintText: "RMS Digital Scale Score",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      rmsPS = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.phone,
                                          color: Color(0xA60D79DD)),
                                      hintText: "RMS PS Scale Score",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      vpt = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.phone,
                                          color: Color(0xA60D79DD)),
                                      hintText: "VPT Scale Score",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      vpt = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.phone,
                                          color: Color(0xA60D79DD)),
                                      hintText: "FIS Scale Score",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  onChanged: (String str) {
                                    setState(() {
                                      rmsBS = str;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.phone,
                                          color: Color(0xA60D79DD)),
                                      hintText: "RMS Blind Score",
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 45,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: 300,
                                  child: FlatButton(
                                    onPressed: () {
                                      _addData(context);
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
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
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                ),
                                //_refresh()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ]),
        ));
  }
}
