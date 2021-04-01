import 'package:flutter/material.dart';
import 'package:funchat/components/RoundButton.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter your email")),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  print(value);
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter your password")),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
                title: 'Login',
                color: Color(0xffFF709F),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
