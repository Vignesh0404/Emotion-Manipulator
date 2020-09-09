import 'dart:io';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    //color: Colors.orange,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
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
                                    image: NetworkImage(widget.img),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    color: index % 2 == 0
                                        ? Colors.lightGreen
                                        : Color(0xFF55BAD3),
                                    width: 2.0)),
                          );
                        }),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name + ",  " + widget.age,
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
                                'Anna Nagar, Chennai',
                                style: TextStyle(fontFamily: 'Poppins'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '  ' + widget.phnum,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 7),
                          Text(
                            '  ' + widget.date + ',  ' + widget.time,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'About',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Note',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )
                ])));
  }
}
