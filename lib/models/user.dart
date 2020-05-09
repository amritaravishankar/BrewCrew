import 'package:flutter/material.dart';

class User
{
  final String uid;

  User({this.uid});

}

class UserData //even though Brew class and this are similar
    {              //this way we can extend one class independently of the other
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}
