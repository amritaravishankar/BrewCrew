import 'package:flutter/material.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/models/user.dart';

void main() => runApp(MyApp()); //root_widget

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( //type of data we get from the stream is custom User
      value: AuthService().user,
      child: MaterialApp(
          home: Wrapper()
      ),
    );
  }
}

//Explanation:
// 1. Provider listens to stream and provides stream info to deescendants. Thus it must wrap the root widget
// 2. Provider hears from a stream, hence StreamProvider
// 3. Specify value to know which stream we're listening to
// 4. AuthService class has the Stream named 'user', thus AuthService().user [auth service instance to access 'user' stream)
// 5. Thus, now all descendant widgets eg. Wrapper can access data provided by Stream