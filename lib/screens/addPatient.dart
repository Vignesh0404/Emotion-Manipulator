import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalRnD/screens/camera.dart';
import 'package:dentalRnD/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:extended_image/extended_image.dart';

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
  String rmsPSg = '';
  String vpt = '';
  String fis = '';
  String rmsBS = '';
  String uid;
  String email;
  AssetImage sadimg;
  String cry;
  String smile;
  String smirk;
  String poker;
  String angry;
  int counter = 0;
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

  void clearCache() async {
    DefaultCacheManager manager = new DefaultCacheManager();
    manager.emptyCache();
  }

  void dialogBox(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 80,
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
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future _addData(BuildContext context) async {
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
        "rms digital scale": rmsDSS, //done
        "rms ps scale score": rmsPS, //done
        "vpt scale score": vpt,
        "fis scale score": fis,
        'rms blind score': rmsBS,
        "uid": uid,
        "url": webUrl,
        "rms ps girls": rmsPSg, //done
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

    dialogBox(context);
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
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Camera()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  clearCache();
                  // DefaultCacheManager().removeFile(
                  //     'https://dental-rnd.herokuapp.com/static/' +
                  //         uid +
                  //         '_input_sad.jpg');
                  // DefaultCacheManager().removeFile(
                  //     'https://dental-rnd.herokuapp.com/static/' +
                  //         uid +
                  //         '_input_poker.jpg');
                  // DefaultCacheManager().removeFile(
                  //     'https://dental-rnd.herokuapp.com/static/' +
                  //         uid +
                  //         '_input_smile.jpg');
                  // DefaultCacheManager().removeFile(
                  //     'https://dental-rnd.herokuapp.com/static/' +
                  //         uid +
                  //         '_input_smirk.jpg');
                  // DefaultCacheManager().removeFile(
                  //     'https://dental-rnd.herokuapp.com/static/' +
                  //         uid +
                  //         '_input_sligthlysad.jpg');
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => this.build(context)));
                })
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
                              image: NetworkImage(
                                'https://dental-rnd.herokuapp.com/static/' +
                                    uid +
                                    '_input_sad.jpg?dummy=${counter++}',
                              ),
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
                              image: NetworkImage(
                                'https://dental-rnd.herokuapp.com/static/' +
                                    uid +
                                    '_input_poker.jpg?dummy=${counter++}',
                              ),
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
                              image: NetworkImage(
                                  'https://dental-rnd.herokuapp.com/static/' +
                                      uid +
                                      '_input_smile.jpg?dummy=${counter++}'),
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
                              image: NetworkImage(
                                  'https://dental-rnd.herokuapp.com/static/' +
                                      uid +
                                      '_input_smirk.jpg?dummy=${counter++}'),
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
                              image: NetworkImage(
                                  'https://dental-rnd.herokuapp.com/static/' +
                                      uid +
                                      '_input_sligthlysad.jpg?dummy=${counter++}'),
                              fit: BoxFit.cover),
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
                              height: 700,
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'Poppins'),
                                      border: InputBorder.none),
                                  style: TextStyle(color: Colors.black),
                                ),
                                //RMS DIGITAL SCALE
                                Row(
                                  children: <Widget>[
                                    rmsDSS == ''
                                        ? Text(
                                            '(0)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '($rmsDSS)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          ),
                                    Container(
                                      width: 255,
                                      child: Text(
                                        '     RMS Digital Scale   ',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 350,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'RMS Digital Scale',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsDSS = '1';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Broad Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Digital Scale: ' + rmsDSS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                            uid +
                                                                            '_input_smile.jpg?dummy=${counter++}'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsDSS = '2';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Regular Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Digital Scale: ' + rmsDSS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                            uid +
                                                                            '_input_smirk.jpg?dummy=${counter++}'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsDSS = '3';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Normal Poker face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Digital Scale: ' + rmsDSS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                            uid +
                                                                            '_input_poker.jpg?dummy=${counter++}'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsDSS = '4';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Slightly Sad face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Digital Scale: ' + rmsDSS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                            uid +
                                                                            '_input_sligthlysad.jpg?dummy=${counter++}'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              rmsDSS = '5';
                                                            });
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                      content: Container(
                                                                          height: 100,
                                                                          width: 80,
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Center(
                                                                                child: Text(
                                                                                  'Crying face',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 25,
                                                                              ),
                                                                              Text('RMS Digital Scale: ' + rmsDSS,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Poppins',
                                                                                  ))
                                                                            ],
                                                                          )));
                                                                });
                                                          },
                                                          child: Container(
                                                            width: 90.0,
                                                            height: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage('https://dental-rnd.herokuapp.com/static/' +
                                                                          uid +
                                                                          '_input_sad.jpg?dummy=${counter++}'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),

                                //RMS PICTORIAL SCALE
                                Row(
                                  children: <Widget>[
                                    rmsPS == ''
                                        ? Text(
                                            '(0)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '($rmsPS)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '    RMS Pictorial Scale - Boys',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 350,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'RMS Pictorial Scale - Boys',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPS = '1';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Broad Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/boys1.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPS = '2';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Regular Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/boys2.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPS = '3';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Normal Poker face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/boys3.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPS = '4';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Slightly Sad face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/boys4.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              rmsPS = '5';
                                                            });
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                      content: Container(
                                                                          height: 100,
                                                                          width: 80,
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Center(
                                                                                child: Text(
                                                                                  'Crying face',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 25,
                                                                              ),
                                                                              Text('RMS Pictorial Scale: ' + rmsPS,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Poppins',
                                                                                  ))
                                                                            ],
                                                                          )));
                                                                });
                                                          },
                                                          child: Container(
                                                            width: 90.0,
                                                            height: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/boys5.jpg'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),

                                //RMS PICTORIAL SCALE - GIRLS
                                Row(
                                  children: <Widget>[
                                    rmsPSg == ''
                                        ? Text(
                                            '(0)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '($rmsPSg)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '    RMS Pictorial Scale - Girls',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 350,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'RMS Pictorial Scale - Girls',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPSg = '1';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Broad Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/girl1.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPSg = '2';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Regular Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/girl2.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPSg = '3';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Normal Poker face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/girl3.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsPSg = '4';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Slightly Sad face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/girl4.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              rmsPSg = '5';
                                                            });
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                      content: Container(
                                                                          height: 100,
                                                                          width: 80,
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Center(
                                                                                child: Text(
                                                                                  'Crying face',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 25,
                                                                              ),
                                                                              Text('RMS Pictorial Scale: ' + rmsPSg,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Poppins',
                                                                                  ))
                                                                            ],
                                                                          )));
                                                                });
                                                          },
                                                          child: Container(
                                                            width: 90.0,
                                                            height: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/girl5.jpg'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),

                                //RMS BLIND SCALE
                                Row(
                                  children: <Widget>[
                                    rmsBS == ''
                                        ? Text(
                                            '(0)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '($rmsBS)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '    RMS Tactile Scale ',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 350,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'RMS Tactile Scale',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsBS = '1';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Broad Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Tactile Scale: ' + rmsBS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/blind1.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsBS = '2';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Regular Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Tactile Scale: ' + rmsBS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/blind2.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsBS = '3';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Normal Poker face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Tactile Scale: ' + rmsBS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/blind3.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                rmsBS = '4';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Slightly Sad face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Tactile Scale: ' + rmsBS,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/blind4.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              rmsBS = '5';
                                                            });
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                      content: Container(
                                                                          height: 100,
                                                                          width: 80,
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Center(
                                                                                child: Text(
                                                                                  'Crying face',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 25,
                                                                              ),
                                                                              Text('RMS Tactile Scale: ' + rmsBS,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Poppins',
                                                                                  ))
                                                                            ],
                                                                          )));
                                                                });
                                                          },
                                                          child: Container(
                                                            width: 90.0,
                                                            height: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/blind5.jpg'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),

                                //RMS fis
                                Row(
                                  children: <Widget>[
                                    fis == ''
                                        ? Text(
                                            '(0)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '($fis)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '    Facial Image Scale ',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 350,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'RMS Facial Image Scale',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                fis = '1';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Broad Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Facial Image Scale: ' + fis,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/fis1.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                fis = '2';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Regular Smile',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Facial Image Scale: ' + fis,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/fis2.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                fis = '3';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Normal Poker face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Facial Image Scale: ' + fis,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/fis3.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                fis = '4';
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                        content: Container(
                                                                            height: 100,
                                                                            width: 80,
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Center(
                                                                                  child: Text(
                                                                                    'Slightly Sad face',
                                                                                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                Text('RMS Facial Image Scale: ' + fis,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                    ))
                                                                              ],
                                                                            )));
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/fis4.jpg'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              fis = '5';
                                                            });
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                      content: Container(
                                                                          height: 100,
                                                                          width: 80,
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Center(
                                                                                child: Text(
                                                                                  'Crying face',
                                                                                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 25,
                                                                              ),
                                                                              Text('RMS Facial Image Scale: ' + fis,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Poppins',
                                                                                  ))
                                                                            ],
                                                                          )));
                                                                });
                                                          },
                                                          child: Container(
                                                            width: 90.0,
                                                            height: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/fis5.jpg'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),

                                //Venham Picture Test
                                Row(
                                  children: <Widget>[
                                    vpt == ''
                                        ? Text(
                                            '(0)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '($vpt)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue),
                                          ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '    Venham Picture Test Scale ',
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: 450,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'Venham Picture Test',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '1';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt1.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '2';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt2.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '3';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt3.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '4';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt4.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '5';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt5.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '6';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt6.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '7';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt7.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                vpt = '8';
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 105.0,
                                                              height: 90.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/vpt8.jpg'),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),

                                SizedBox(
                                  height: 65,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: 300,
                                  child: FlatButton(
                                    onPressed: () {
                                      rmsDSS == ''
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)), //this right here
                                                  child: Container(
                                                    height: 120,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Please select a Scale for your patient!',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins'),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                          : _addData(context);
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
