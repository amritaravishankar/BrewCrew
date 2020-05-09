import 'package:flutter/material.dart';
import 'package:brew_crew/authenticate/authenticate.dart';
import 'package:brew_crew/home/home.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); //we're accessing the "User" data from the Provider. We provide data type so it knows which stream to refer to

    //return home or authenticate
    if(user==null)    //user = null indicates user is logged out
      return Authenticate();
    else
      return Home();
  }
}
