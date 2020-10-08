import 'package:dentalRnD/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailid = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController qualification = new TextEditingController();
  TextEditingController linkedin = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

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
                    Text(
                      "Your response has be saved, we'll get back to you shortly!",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new LoginPage()));
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

  Future registerNow(BuildContext context) async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          Firestore.instance.collection('registerRequests');
      await reference.add({
        "name": name.text,
        "email": emailid.text,
        "password": password.text,
        "qualification": qualification.text,
        "linkedin": linkedin.text
      });
    });

    dialogBox(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
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
                "Register Now to Dental R&D!",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 170),
              child: Text(
                "Fill in the form to request for an account, we'll look into your profile and get back to you!",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 12, top: 230),
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFFF4F4FA),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: name,
                        /*validator: (value) => value.isEmpty
                            ? 'Please enter your Email Address'
                            : null, */
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(),
                      TextFormField(
                        controller: emailid,
                        /*validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null, */
                        //obscureText: true,
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
                          hintText: 'Password - 6 characters min',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(),
                      TextFormField(
                        controller: qualification,
                        /*validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null, */
                        // obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Qualification',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.label_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(),
                      TextFormField(
                        controller: linkedin,
                        /*validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null, */
                        // obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'LinkedIn Profile Url',
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.link,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 16, top: 510),
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
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: FloatingActionButton(
                            onPressed: () {
                              // print(name);
                              // print(emailid);
                              // print(password);
                              // print(qualification);
                              // print(linkedin);
                              // dialogBox(context);
                              registerNow(context);
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
