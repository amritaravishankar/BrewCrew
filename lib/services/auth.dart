import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';

class AuthService //instance of this class will let you interact with backend
{
  final FirebaseAuth _auth = FirebaseAuth.instance; //creates instance of FirebaseAuth class: gives us access to below functions

  //create user object based on Firebase user
  User _userFromFirebaseUser(FirebaseUser user)
  {
      return user!=null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  //auth change user stream - used to listen from firebase whether it's a user object (logged in) or null and hence display home or sign accordingly
  //we get back a firebase user and it's a getter so we use get keyword
  Stream<User> get user
  {
    return _auth.onAuthStateChanged //we're returning onAuthStateChanged on _auth object
              .map((FirebaseUser user) => _userFromFirebaseUser(user));         //map from firebase user to custom user
             // .map(_userFromFirebaseUser); Alternative way: Firebase user automatically gets passed to this function
  }

  //register with email and password
  Future signUpWithEmailAndPassword(String email, String password) async
  {
    try
    {
         AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
         FirebaseUser user = result.user;
         //create a document for new user
         await DatabaseService(uid: user.uid).updateUserData('New Crew Member', '0', 100);
         return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  Future handleSignUp(var firstname, var lastname, var email, var password) async
  {

    FirebaseUser user;
    String name;
    try {
      user = (await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password)).user;
      name = firstname + " " + lastname;
      await DatabaseService(uid: user.uid).updateUserData(name, '0', 100);
      return _userFromFirebaseUser(user);
    }

    catch(e){
      return null;
    }

  }

  //sign out
  Future signOut() async
  {
    try
    {
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async
  {

    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }

  }


}
