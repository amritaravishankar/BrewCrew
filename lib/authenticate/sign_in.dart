import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';


class SignIn extends StatefulWidget { //constructor required in the widget itself not in the state

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool passwordNotVisible=true;

  String email = " "; //text field state
  String password = " "; //password state
  String error = " "; //error message

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
        backgroundColor: Colors.brown,
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
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height:60.0),
                        //Image.asset("assets/coffee_logo.png", width: 85.0, height: 85.0,),
                        Text("Brew Crew", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500, letterSpacing: 1.5, color: Colors.white)),
                        SizedBox(height:20.0),
                        Text("SIGN IN", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, letterSpacing: 1.5, color: Colors.white)),
                        SizedBox(height:40.0),
                        TextFormField(
                          style: TextStyle(color:Colors.white),
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            hintStyle: TextStyle(color:Colors.white.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                          ) ,
                          validator: (val) => val.isEmpty? 'Enter an e-mail': null,
                          onChanged: (val){ //gives us the value inside the form field
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height:30.0),
                        TextFormField(
                          style: TextStyle(color:Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            hintStyle: TextStyle(color:Colors.white.withOpacity(0.6)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordNotVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Update the state i.e. toggle the state of passwordVisible variable
                                setState(() {
                                  passwordNotVisible = !passwordNotVisible;
                                });
                              },
                            ),
                          ) ,
                          obscureText: passwordNotVisible,
                          validator: (val) => val.length<=6? 'Enter a password of 6+ characters': null,
                          onChanged: (val){ //gives us the value inside the form field
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height:30.0),
                        RaisedButton(
                          color: Colors.white,
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(color: Colors.black,),
                          ),
                          onPressed: () async{
                            if(_formKey.currentState.validate()) //uses the validator properties
                                {
                              setState(()=>loading = true);
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result==null)
                              {
                                setState((){
                                  error = 'Incorrect credentials: Could not Sign In';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height:12.0),
                        Text(error, style: TextStyle(color: Colors.white, fontSize: 18.0)),
                        SizedBox(height:100),
                        FlatButton(
                            onPressed: (){
                              widget.toggleView();
                            },
                            child: Text("NEW USER? REGISTER!",style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1.5))
                        ),
                        SizedBox(height:80),
                        Text(''),
                      ],
                    ),
                ),
          ),
        ),
    );
  }
}
