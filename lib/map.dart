import 'package:cougar/models/ride_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  String source = "Current Location";
  String destination = "Destination";
  String phoneNumber;
  String user;
  final rideRequest = RideRequest();

  //  GoogleMapController mapController;

  // final LatLng _center = const LatLng(5.7598, -0.2197);
  // Location location = new Location();
  // LocationData currentLocation;

  //   @override
  // void initState() {

  //   super.initState();
  //   location.onLocationChanged().listen((value) {
  //     setState(() {
  //       currentLocation = value;
  //     });
  //     print(currentLocation.longitude);

  //   });
  // }

  // LatLng _center = LatLng(currentLocation.latitude, currentLocation.longitude);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    _read().then((value) {
      try {
        setState(() => rideRequest.request['firstName'] = value[1]);
        setState(() => rideRequest.request['phoneNumber'] = value[2]);
      } catch (e) {
        print(e);
      }
    });
    // var userLocation = _getLocation();
    // print("Getting the user location");
    // userLocation.then((user) {
    //     double lat = user.latitude;
    //     double long = user.longitude;
    //     print("Tthis is the location");}
    //     );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(
              children: <Widget>[
              Container(
                 color: Colors.white,
                child: CustomPaint(
                  // child: Text("Going On Campus"),
                  size: Size.infinite,
                  painter:CurvePainter(),
              )),
              Container(
                padding: EdgeInsets.only(left: 60.0, top: 100.0, right: 0.0),
                  child: Text("Going on campus..?",
                  style:  GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),),
              ),
          Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 350.0),
          child: Center(
              child: Column(
            /* 
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly, */
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: source,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    rideRequest.request['currentLocation'] = newValue;
                    source = newValue;
                  });
                },
                items: <String>[
                  "Current Location",
                  "Charlotte/Queenstar/Ceewus/RideAlong",
                  "Tanko",
                  "Dufie/Hosanna",
                  "Masere/Columbiana/Lambert",
                  "Engineering",
                  "Fab Lab/Health Center/ Ashpitch",
                  "Big Ben/New Car Park",
                  "Old Car Park"
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30.0,),
              DropdownButton<String>(
                value: destination,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    rideRequest.request['destination'] = newValue;
                    destination = newValue;
                  });
                },
                items: <String>[
                  "Destination",
                  "Charlotte/Queenstar/Ceewus/RideAlong",
                  "Tanko",
                  "Dufie/Hosanna",
                  "Masere/Columbiana/Lambert",
                  "Engineering",
                  "Fab Lab/Health Center/ Ashpitch",
                  "Big Ben/New Car Park",
                  "Old Car Park"
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30.0,),
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
                              try {
                              rideRequest.save();
                              Navigator.of(context).pushNamed("/DriverProfile",
                              arguments: DriverScreenArguments(rideRequest.request['currentLocation'],rideRequest.request['destination'])
                              );
                              }
                              catch(e){
                                print(e);
                              }

                            },
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Request A Ride",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold)))),
                      )))
            ],
          )),
        )
        ]))
    );
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'isLoggedIn';
    final value = prefs.getStringList(key);
    return value;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff392850);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class DriverScreenArguments{
  final String currentLocation;
  final String destination;

  DriverScreenArguments(this.currentLocation, this.destination);
}