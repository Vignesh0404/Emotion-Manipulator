import 'package:dentalRnD/screens/blogDetails.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dialogBox(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
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
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Color(0xFF545D68),
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Color(0xFF545D68),
                ),
                onPressed: () {})
          ],
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black45, offset: Offset(0.0, 3))
                      ]),
                ),
                Container(
                  alignment: FractionalOffset.centerRight,
                  child: Image(
                    image: AssetImage('assets/home1.png'),
                    height: 200,
                    width: 190,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 30.0, top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "What do we do?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "lorem pisum asdasda",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 30.0, top: 120.0),
                  child: Container(
                    height: 40.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFCCDDEC),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '   Learn More',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              launch(
                                  'http://www.jisppd.com/article.asp?issn=0970-4388;year=2015;volume=33;issue=1;spage=48;epage=52;aulast=shetty');
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Latest Articles',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                )),
            Stack(
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
            )
          ],
        ));
  }
}

class BlogDetails extends StatelessWidget {
  const BlogDetails({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: ListView.builder(
          itemCount: 2,
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
                        height: 140,
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
          }),
    );
  }
}
