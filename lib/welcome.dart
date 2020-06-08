import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget{

  @override
  _Welcome createState() => _Welcome();
}


  class _Welcome extends State {
    String name;


    @override
    Widget build(BuildContext context){

      
    _read().then((value){
      name = value[1];
    });

      return Scaffold(
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                  child: Text("Welcome",
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 145.0, 0.0, 10.0),
                  child: Text(name,
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
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
        ]
        )
      );
    }

         _read() async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'isLoggedIn';
        final value = prefs.getStringList(key);
         return value;
    }
  }
