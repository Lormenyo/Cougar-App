import 'package:flutter/material.dart';
import 'models/user.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentRegister extends StatefulWidget {
  // FirebaseApp app;
  
  @override
  _StudentRegister createState() => _StudentRegister();
}

class _StudentRegister extends State {
  final _user = User();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                  child: Text("Hello",
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 145.0, 0.0, 10.0),
                  child: Text("There",
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(235.0, 155.0, 0.0, 0.0),
                  child: Text(".",
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  autovalidate: false,
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter your first name.';
                    else
                    // setState(() => _user.user['firstName'] = value);
                      return null;
                  },
                  onChanged: (val) =>
                      setState(() => _user.user['firstName'] = val),
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                      labelText: "FIRST NAME",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidate:false,
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter your phone number.';
                    else
                    // setState(() => _user.user['phoneNumber'] = value);
                      return null;
                  },
                  onChanged: (val) =>
                      setState(() => _user.user['phoneNumber'] = val),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                      labelText: "PHONE NUMBER",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber))),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  width: 300.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.amberAccent,
                    color: Colors.amber,
                    elevation: 7.0,
                    child: GestureDetector(
                        onTap: () {

                            if  (_user.user['firstName'] == null ||
                              _user.user['phoneNumber'] == null ) {
                            _showDialog();
                          }
                          else if (_user.user['firstName'].isEmpty ||
                              _user.user['phoneNumber'].isEmpty) {
                            _showDialog();
                          }
                        else {
                         setState(() => _user.user['typeOfUser'] = 'student');
                          setState(() => _user.user['code'] = 0000.toString());
                          _user.save();
                          print("saving the output");
                          print(_user.user['firstName']);
                          _save(_user.user['firstName'], _user.user['phoneNumber']);
                          Navigator.of(context).pushNamed("/Map");
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text("SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold)))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );


  }

  
    // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Invalid or Empty Input"),
          content: new Text("Enter your First Name and phone Number", 
 /*          style: TextStyle(
            fontFamily: 'Sa'
          ), */
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


      _save(String firstName, String phoneNumber) async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'isLoggedIn';
        final value = ['1', firstName, phoneNumber];
        // final value = 1;
        print("value $value");
        prefs.setStringList(key, value);
        // prefs.setStringList(key, value);
        print('saved $value');
      }
}


