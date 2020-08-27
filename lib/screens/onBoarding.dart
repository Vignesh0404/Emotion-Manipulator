import 'package:dentalRnD/auth/loginpage.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: Text(
                'Done',
                style: TextStyle(
                    color: Color(0xFF6F6FA8),
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                  image: 'assets/1.jpg',
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent),
              makePage(
                  reverse: true,
                  image: 'assets/1.jpg',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent),
              makePage(
                  image: 'assets/1.jpg',
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        image,
                        fit: BoxFit.fitWidth,
                        width: 900,
                        height: 250,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFB7043E),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFFC7E2F),
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          reverse
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        image,
                        fit: BoxFit.fitWidth,
                        width: 700,
                        height: 300,
                      ),
                    )
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Color(0xFF6F6FA8), borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class Strings {
  static var stepOneTitle = "Lorem and pisum";
  static var stepOneContent =
      "for your children to have at school today and tomorrow";
  static var stepTwoTitle = "Lorem and pisum";
  static var stepTwoContent =
      "homemade meals will be prepared by our chefs who alwas take proper sanitary precautions";
  static var stepThreeTitle = "Lorem and pisum";
  static var stepThreeContent =
      "will be done directly to school to serve our food hot";
}
