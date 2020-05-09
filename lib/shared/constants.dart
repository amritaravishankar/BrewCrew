import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintText: 'Select number of sugar(s)',
  hintStyle: TextStyle(color:Colors.black),
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);