import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget { //constructor required in the widget itself not in the state

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //this key is used to identify the form, we'll associate it with the Global Key
  bool loading = false;
  bool passwordVisible = true;

  String email = " "; //text field state
  String password = " "; //password state
  String fname = " "; //first name
  String lname = " "; //last name
  String error = " "; //error message

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
        backgroundColor: Colors.brown[500],
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/coffee2.2png.png'),
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  )
              ),
              padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey, //global key gonna keep track of state of this form
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 45.0),
                      Text("Brew Crew", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500, letterSpacing: 1.5, color: Colors.white)),
                      SizedBox(height:20.0),
                      Text("SIGN UP", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, letterSpacing: 1.5, color: Colors.white)),
                      SizedBox(height:40.0),
                      TextFormField(
                        style: TextStyle(color:Colors.white),
                        decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color:Colors.white.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.account_circle, color: Colors.white)
                        ) ,
                        validator: (val) => val.isEmpty? 'Enter your first name': null, //the string will be the help text
                        onChanged: (val){ //gives us the value inside the form field
                          setState(() {
                            fname = val;
                          });
                        },
                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        style: TextStyle(color:Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color:Colors.white.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.account_circle, color: Colors.white)
                        ) ,
                        validator: (val) => val.isEmpty? 'Enter your last name': null, //the string will be the help text
                        onChanged: (val){ //gives us the value inside the form field
                          setState(() {
                            lname = val;
                          });
                        },
                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        style: TextStyle(color:Colors.white),
                        decoration: InputDecoration(
                            hintText: 'E-mail',
                            hintStyle: TextStyle(color:Colors.white.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.email, color: Colors.white)
                        ) ,
                        validator: (val) => val.isEmpty? 'Enter an e-mail': null, //the string will be the help text
                        onChanged: (val){ //gives us the value inside the form field
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        style: TextStyle(color:Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color:Colors.white.withOpacity(0.6)),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ) ,
                        obscureText: passwordVisible,
                        validator: (val) => val.length<6? 'Enter a password of 6+ characters': null,
                        onChanged: (val){ //gives us the value inside the form field
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height:30.0),
                      RaisedButton(
                        color: Colors.white,
                        child: Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.black,),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState.validate()) //uses the validator properties
                              {
                            setState(()=>loading = true);
                            dynamic result = await _auth.handleSignUp(fname, lname, email, password);

                            if(result==null){
                              setState((){
                                error = 'Incorrect credentials: Could not Register';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height:50.0),
                      Text(error, style: TextStyle(color: Colors.white, fontSize: 14.0)),
                      FlatButton(
                          onPressed: (){
                            widget.toggleView();
                          },
                          child: Text("ALREADY REGISTERED? SIGN IN",style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1.5))
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}
