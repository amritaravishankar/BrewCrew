import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/home/settings_form.dart';
import 'package:brew_crew/authenticate/sign_in.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel()
    {
      showModalBottomSheet(context: context, builder: (context){ //returns a widget tree
        return Container(
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee2.2png.png'),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.12), BlendMode.dstATop),
                fit: BoxFit.cover,
              )
          ),
          child: SettingsForm(),
        );

      });//built-in function + the builder will build the update form
    }


    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews, //instance of database class to access its stream
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brew Crew Home'),
          centerTitle: true,
          backgroundColor: Colors.brown[800],
        ),
        drawer: Drawer(
            child:Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 15.0),
                    color: Colors.brown[800],
                    height: 200,
                    width: 303.5,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/coffee_logo.png', height:80, width:80),
                        SizedBox(height: 15.0),
                        Text('BREW CREW',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            )),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    leading: Icon(
                        Icons.settings,
                        color: Colors.grey.shade800),
                    title: Text('Update Brew Requirements', style: TextStyle(fontSize: 15.0 )),
                    onTap: () {
                      Navigator.pop(context);
                      _showSettingsPanel();
                      },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.grey.shade800),
                    title: Text('Logout', style: TextStyle(fontSize: 15.0 )),
                    onTap: () async {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignIn()), (
                              r) => false);
                        await _auth.signOut();
                    },
                  ),
                ),
              ],
            )
        ),
        body: BrewList(),
      ),
    );
  }
}
