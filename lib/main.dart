import 'package:flutter/material.dart';
import 'package:funchat/screens/welcome_screen.dart';
import 'package:funchat/screens/login_screen.dart';
import 'package:funchat/screens/registration_screen.dart';
import 'package:funchat/screens/chat_screen.dart';

void main() => runApp(FunChat());

class FunChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
