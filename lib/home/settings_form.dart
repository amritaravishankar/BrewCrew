import 'package:flutter/material.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentSugars;
  int _currentStrength;
  String _currentName;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); //can access using the Provider similar to wrapper class

    return StreamBuilder<UserData>( //we get back userData based on our custom model
        stream: DatabaseService(uid: user.uid).userData, //name of stream used in Database Service class
        builder: (context, snapshot){ //returns a widget tree, this snapshot refers to the data coming down the stream and not Firebase snapshot
          if(snapshot.hasData)
          {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Brew Requirements',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  TextFormField(
                    initialValue: userData.name,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Pick a username if you wish!',
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      contentPadding: EdgeInsets.all(12.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 0.5),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                                value: _currentSugars ?? userData.sugars,
                                items: sugars.map((sugar) {
                                  return DropdownMenuItem(
                                      value: sugar,
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset("assets/sugar_icon.png", height:40.0, width:40.0),
                                          SizedBox(width: 10.0,),
                                          Text('${sugar} sugar(s)'),
                                        ],
                                      )
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() => _currentSugars = val),
                                decoration: InputDecoration(
                                  hintText: 'Select number of sugar(s)',
                                  //prefixIcon: Icon(Icons.crop_square, color: Colors.black),
                                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.brown, width: 0.5),
                                  ),
                                )
                            ),
                  SizedBox(height: 15.0),

                  Text('Strength of your brew: ',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,),
                  SizedBox(height: 5.0),

                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.brown[_currentStrength??100],
                        backgroundImage: AssetImage('assets/coffee_icon.png'),
                        radius: 22.0,
                      ),
                      Container(
                        width: 245,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3.3,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          ),
                          child: Slider(
                            min: 100.0,
                            max: 900.0,
                            divisions: 8,
                            value: (_currentStrength ?? userData.strength).toDouble(),
                            activeColor: Colors.brown[_currentStrength ?? userData.strength],
                            inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                            onChanged: (val) =>
                                setState(() => _currentStrength = val.round()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9.5),
                  //update button
                  Center(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        'UPDATE',
                        style: TextStyle(color: Colors.black,),
                      ),
                      onPressed: () async {
                          if(_formKey.currentState.validate())
                          {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName   ?? userData.name,
                                _currentSugars ?? userData.sugars,
                                _currentStrength ?? userData.strength
                            );
                          }
                          Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          else {
            return Container(child: Text("Unable to load"),);
          }
        }
    );
  }
}

