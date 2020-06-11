import "package:flutter/material.dart";
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
// import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'map.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './service/service_locator.dart';
import './service/call_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class DriverProfile extends StatefulWidget {
  _DriverProfileState createState() => new _DriverProfileState();
}

class _DriverProfileState extends State {
   List data;
   final CallService _service = locator<CallService>();
   String from;
   String to;
   String fare;


  @override
  void initState() {
    super.initState();
 
    this.getJsonData();
  }


  Future<List> getJsonData() async {
    // final from = "Tanko";
    // final to = "Dufie/Hosanna";
    final prefs = await SharedPreferences.getInstance();
    final key = 'ride';
   final value = prefs.getStringList(key);
    setState((){
       from = value[0];
        to = value[1];
    });

    final String url =
        "https://kugar.herokuapp.com/getRideDetails?currentLocation=$from&destination=$to";

    var response = await http.get(
        // encode the url to remove spaces
        Uri.encodeFull(url),
        // Accept only json data
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json"
        });
    // print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      // print(convertDataToJson);
      data = convertDataToJson['RideDetails'];
      fare = data[1];
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    // final DriverScreenArguments args = ModalRoute.of(context).settings.arguments
    if (data == null) {
      return new Scaffold(
        backgroundColor: Color(0xff392850),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
           child: SpinKitWave(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.amber: Colors.amber,
      ),
    );
  },
)),
SizedBox(height: 10.0),
      Text("Looking for your ride...",
      style: GoogleFonts.openSans(
          color: Colors.amber
      ),)
            ]  )
          );

    }
   
    return new Scaffold(
        backgroundColor: Color(0xff392850),
        body: new Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.width / 2,
              left: 10.0,
              child: Text("Available Drivers",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 25.0,
                  )),
            ),
            Center(
              child: SizedBox(
                  height: 200.0,
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data == null ? 0 : data[0].length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(data[0][index][0]);
                        return Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            // height: 50.0,
                            child: new Card(
                                child: new Column(
                              children: <Widget>[
                                SizedBox(height: 7.0),
                                GFAvatar(),
                                SizedBox(height: 10.0),
                                Text(
                                  data[0][index][0],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                ),
                                SizedBox(height: 10.0),
                                Center(
                                  child: Container(
                                    width: 150.0,
                                      decoration:
                                          BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.all(Radius.circular(7.0))),
                                      child: 
                                      
                                      InkWell(
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                        GFIconButton(
                                          color: GFColors.WARNING,
                                          icon: Icon(Icons.phone),
                                          onPressed: () => {},
                                        ),
                                        Text(
                                          data[0][index][1],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                      onTap: () {
                                        _service.call(data[0][index][1]);
                                      },
                                      )),
                                )
                              ],
                            )));
                      })),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height*0.22,
              left: 10.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.95,
                height: 70.0,
                child: 
                Container(
                  height: 80.0,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: ListTile(
                        leading: Icon(Icons.euro_symbol, size: 50),
                        title: Text("GHC $fare"),
                        subtitle: Text('Pay in Cash'),
                      )))),

                    Positioned(
                   bottom: MediaQuery.of(context).size.height*0.10,
                   left: 10.0,
                  //  right: 20.0,
                  height: 40.0,
                  width: MediaQuery.of(context).size.height*0.50,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.amberAccent,
                    color: Colors.amber,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () => {

                      },
                      child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text("CONFIRM PICK UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold)))
                    )
                  ))          
          ],
        ));
  }
}
