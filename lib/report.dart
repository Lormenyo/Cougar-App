import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Report extends StatefulWidget {
  @override
  _Report createState() => new _Report();
}

class _Report extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 0.0,bottom: 100.0),
                child: Text("Make a Report",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 50.0,
                    ))),
            Container(
              padding: EdgeInsets.only(left:10.0, top: 10.0, right: 10.0),
              child: TextField(
                 keyboardType: TextInputType.multiline,
                 maxLines: null,
                 decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: 'Input your messaage',
                            prefixIcon:
                                Icon(Icons.report, color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(5.0),
                            )),
              )
              ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                height: 50.0,
                child: Container(
                    height: 40.0,
                    width: 200.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.amberAccent,
                        color: Colors.amber,
                        elevation: 7.0,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/Welcome");
                            },
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Submit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold)))))))
          ],
        ),
      ),
    );
  }
}
