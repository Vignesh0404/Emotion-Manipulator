import 'package:dentalRnD/auth/forgotpass.dart';
import 'package:dentalRnD/auth/register.dart';
import 'package:dentalRnD/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailid = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> loginAuth() async {
    if (validateAndSave()) {
      print(emailid.text);
      print(password.text);
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailid.text, password: password.text))
            .user;
        assert(user != null);
        assert(await user.getIdToken() != null);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs?.setBool("isLoggedIn", true);
        print(user.uid);
        print(user.email);
        await Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Navigation()));
      } catch (e) {
        //print("error");
        print('Error: $e');

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          },
        );
      }
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
                "Welcome to Dental R&D!",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 170),
              child: Text(
                "Enter your email address and password to get access to your account.",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 12, top: 230),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFF4F4FA),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailid,
                        /*validator: (value) => value.isEmpty
                            ? 'Please enter your Email Address'
                            : null, */
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
                      TextFormField(
                        controller: password,
                        /*validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null, */
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 16, top: 350),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: FloatingActionButton(
                            onPressed: () {
                              loginAuth();
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
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 16, top: 460),
                  child: Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 1.0,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new RegisterPage()));
                    },
                    child: Text(
                      "Request one now",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
