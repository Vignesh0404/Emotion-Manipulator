import 'package:dentalRnD/auth/loginpage.dart';
import 'package:dentalRnD/screens/account.dart';
import 'package:dentalRnD/screens/blog.dart';
import 'package:dentalRnD/screens/camera.dart';
import 'package:dentalRnD/screens/files.dart';
import 'package:dentalRnD/screens/home.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentTab = 0;
  final List<Widget> screens = [Home(), Files(), Blog(), Account()];

  Widget currentScreen = Home();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Camera()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xA60D79DD),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Home();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Color(0xFF86B9E6) : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color(0xFF86B9E6)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Files();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color:
                              currentTab == 1 ? Color(0xFF86B9E6) : Colors.grey,
                        ),
                        Text(
                          "Data",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color(0xFF86B9E6)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Blog();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.book,
                          color:
                              currentTab == 2 ? Color(0xFF86B9E6) : Colors.grey,
                        ),
                        Text(
                          "Blog",
                          style: TextStyle(
                            color: currentTab == 2
                                ? Color(0xFF86B9E6)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Account();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color:
                              currentTab == 3 ? Color(0xFF86B9E6) : Colors.grey,
                        ),
                        Text(
                          "Account",
                          style: TextStyle(
                            color: currentTab == 3
                                ? Color(0xFF86B9E6)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
