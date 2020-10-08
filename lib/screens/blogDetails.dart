import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPreview extends StatefulWidget {
  BlogPreview(
      {this.body,
      this.citation,
      this.date,
      this.heading,
      this.img,
      this.index,
      this.link});
  final String heading;
  final String body;
  final String citation;
  final String date;
  final String img;
  final String link;
  final index;
  @override
  _BlogPreviewState createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<BlogPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Icons.refresh,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 12, top: 14, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'blog',
                  style: TextStyle(letterSpacing: 4),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  widget.heading + '!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Dr Shetty' +
                      ' \u2022  ' +
                      widget.date +
                      ' \u2022 ' +
                      ' 10 mins read',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.link,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                        onTap: () {
                          launch(widget.link);
                        },
                        child: Text(
                          '   ' + widget.link,
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                SizedBox(height: 23),
                Center(
                    child: Container(
                  height: 230,
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.body,
                  style: TextStyle(letterSpacing: 1.5),
                ),
                SizedBox(height: 28),
                Text('Citation: ' + widget.citation),
                SizedBox(height: 28),
              ],
            ),
          ),
        ));
  }
}
