import 'dart:async';
import 'dart:io';
import 'package:dentalRnD/screens/addPatient.dart';
import 'package:dentalRnD/widgets/loading.dart';
import 'package:dentalRnD/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';

class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  Dio dio = new Dio();
  bool loading = false;
  File _image;
  String uid = '';
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        this.uid = value.uid;
        print(uid);
      });
    }).catchError((e) {
      print(e);
    });
  }

  final picker = ImagePicker();

  String fileName;
  List<Filter> filters = presetFiltersList;

  // Widget _refresh() {
  //   Timer timer = new Timer.periodic(new Duration(seconds: 1), (time) {
  //     if (mounted) setState(() {});
  //   });
  //   return Container();
  // }

  Future passImage(BuildContext context) async {
    var image = _image;
    print(image);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Loading(
            getImage: image,
          ),
        )).then((value) => setState(() {}));
  }

  Future cameraImage(context) async {
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    fileName = basename(_image.path);
    var image = imageLib.decodeImage(_image.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text(
            "Add Filters",
            style: TextStyle(color: Colors.black),
          ),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        _image = imagefile['image_filtered'];
      });
      print(_image.path);
    }
    sendImage();
  }

  Future galleryImage(context) async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    fileName = basename(_image.path);
    var image = imageLib.decodeImage(_image.readAsBytesSync());

    image = imageLib.copyResize(image, width: 420);
    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text(
            "Add Filters",
            style: TextStyle(color: Colors.black),
          ),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        _image = imagefile['image_filtered'];
      });
      print(_image.path);
    }

    sendImage();
  }

  Future sendImage() async {
    String base64Image = base64Encode(_image.readAsBytesSync());
    Response response = await Dio().post(
        "http://dental-rnd.herokuapp.com/api?uid=" + uid,
        data: base64Image);

    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Navigation()));
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              //padding: EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("RULES :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins')),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text("1. Make sure the image is square."),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                      "2. Make sure the face is not covered with the patient's hair."),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("3. Make sure the image is of high resolution.")
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(25.0),
            //padding: EdgeInsets.all(1.0),
            height: 360,
            width: double.infinity,

            decoration: BoxDecoration(
              border: Border.all(width: 2),
              color: Color(0xFFE5E5EB),
            ),
            child: _image == null
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/preview.gif'),
                            fit: BoxFit.cover)),
                  )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 20),
                child: Container(
                  height: 40.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFF4F4FA),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '   Gallery',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () async {
                            await galleryImage(context);
                          })
                    ],
                  ),
                ),
              ),
              Container(
                height: 40.0,
                width: 110.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFFF4F4FA),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      '   Camera',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        icon: Icon(Icons.camera),
                        onPressed: () async {
                          await cameraImage(context);
                        })
                  ],
                ),
              ),
              Container(
                height: 40.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFFF4F4FA),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      '   Next',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () async {
                          //await sendImage();
                          await passImage(context);
                        }),
                    //_refresh(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
