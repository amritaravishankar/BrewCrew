import 'package:flutter/material.dart';
import 'package:brew_crew/authenticate/sign_in.dart';
import 'package:brew_crew/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;

  void toggleView()
  {
    setState(() => signIn = !signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: signIn? SignIn(toggleView: toggleView) : Register(toggleView: toggleView),
    );
  }
}
