import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController emailid = new TextEditingController();
  void validateAndSubmit() async {
    print(emailid.text);
    try {
      FirebaseUser user = (await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailid.text)) as FirebaseUser;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
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
                            hintText: ' An Email has been sent! ',
                            hintStyle: TextStyle(fontFamily: 'Poppins')),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
      print('Email sent to: ${emailid.text}');
    } catch (e) {
      print(emailid.text);
      print('Error: $e');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(color: Colors.white //Color(0xFF0f1115),
                ),
            SvgPicture.asset('assets/dots_rectangle.svg'),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: SvgPicture.asset('assets/background_circles.svg')),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                child: SvgPicture.asset('assets/striped_oval.svg')),
            Positioned(
                top: 75,
                left: 20,
                child: SvgPicture.asset('assets/sample_logo.svg')),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 145),
              child: Text(
                "Forgot Password!",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 170),
              child: Text(
                "Enter your email address to get your password reset mail.",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 12, top: 230),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFF4F4FA),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailid,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 16, top: 270),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: FloatingActionButton(
                            onPressed: () {
                              validateAndSubmit();
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
