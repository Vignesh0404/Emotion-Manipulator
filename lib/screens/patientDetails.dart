import 'dart:io';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/material.dart';

class PatientDetails extends StatefulWidget {
  PatientDetails(
      {Key key, this.age, this.name, this.phnum, this.getImage, this.index})
      : super(key: key);
  final String name;
  final String age;
  final String phnum;
  final File getImage;
  final index;

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    var children = List<Widget>();
    children.add(
      FloatingActionRowButton(
        icon: Icon(Icons.edit),
        onTap: () {},
      ),
    );
    children.add(
      FloatingActionRowDivider(),
    );
    children.add(
      FloatingActionRowButton(
        icon: Icon(Icons.delete),
        onTap: () {},
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
              color: Color(0xFF6F6FA8),
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
                                    image: AssetImage('assets/home1.png'),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    color: index % 2 == 0
                                        ? Colors.black
                                        : Color(0xFF6F6FA8),
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
                        children: <Widget>[
                          Text(
                            "Patient details",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          Text(widget.name),
                          Text(widget.age)
                        ],
                      ),
                    ),
                  )
                ])));
  }
}
