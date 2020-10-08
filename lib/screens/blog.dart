import 'package:cloud_firestore/cloud_firestore.dart';
import 'blogDetails.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Blog extends StatefulWidget {
  Blog({Key key}) : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: Firestore.instance.collection('blog').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: BlogDetails(document: snapshot.data.documents),
                );
              })
        ],
      ),
    );
  }
}

class BlogDetails extends StatelessWidget {
  const BlogDetails({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: document.length,
        itemBuilder: (BuildContext context, int i) {
          String heading = document[i].data['heading'].toString();
          String body = document[i].data['body'].toString();
          String img = document[i].data['img'].toString();
          String link = document[i].data['link'].toString();
          String citation = document[i].data['citation'].toString();
          String date = document[i].data['date'].toString();

          return Dismissible(
              key: Key(document[i].documentID),
              background: Container(color: Colors.red[100]),
              onDismissed: (direction) {
                Firestore.instance.runTransaction((transaction) async {
                  DocumentSnapshot snapshot =
                      await transaction.get(document[i].reference);
                  await transaction.delete(snapshot.reference);
                });

                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("Blog Deleted"),
                  backgroundColor: Colors.black,
                ));
              },
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BlogPreview(
                              heading: heading,
                              body: body,
                              date: date,
                              citation: citation,
                              img: img,
                              link: link,
                              index: document[i].reference,
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      height: 135,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  launch(link);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(img),
                                  radius: 50,
                                  //minRadius: 40,
                                ),
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                date + ' \u2022' + ' 10 mins read',
                                style: TextStyle(
                                    color: i % 2 == 0
                                        ? Colors.lightBlue
                                        : Colors.lightGreen),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                width: 210,
                                child: Text(
                                  heading + ',',
                                  style: TextStyle(
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                  width: 210,
                                  height: 50,
                                  child: Text(
                                    body,
                                  ))
                            ],
                          ),
                          //Text(heading),
                          //Text(body),
                          //Text(citation)
                        ],
                      ),
                    ),
                  )));
        });
  }
}
