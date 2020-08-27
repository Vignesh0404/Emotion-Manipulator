import 'package:flutter/material.dart';

class FunctionPicker extends StatefulWidget {
  FunctionPicker({Key key}) : super(key: key);

  @override
  _FunctionPickerState createState() => _FunctionPickerState();
}

class _FunctionPickerState extends State<FunctionPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GridView.count(
        crossAxisCount: 2, //1
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 0.9, //3
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: <Widget>[
          functionGrids('name', 'title', 'title2', 'image', 1, 2)
        ],
      ),
    );
  }

  Widget functionGrids(String name, String title1, String title2, String image,
      int color1, int color2) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          gradient: new LinearGradient(
              colors: [Color(color1), Color(color2)],
              begin: Alignment.centerLeft,
              end: new Alignment(1.0, 1.0))),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                      image: new NetworkImage(image), fit: BoxFit.fill)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        title1,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      child: Icon(
                        Icons.cloud_circle,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      child: Text(
                        title2,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
