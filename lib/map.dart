 import 'package:cougar/models/ride_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
    //   String source;
    // String destination;
    String phoneNumber;
    String user;
    final rideRequest = RideRequest();


   GoogleMapController mapController;

  final LatLng _center = const LatLng(5.7598, -0.2197);
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
  


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  
  @override
  Widget build(BuildContext context) {
      _read().then((value){
      try{
      setState(() => rideRequest.request['firstName'] =  value[1]);
      setState(() => rideRequest.request['phoneNumber'] =  value[2]);
      }
      catch(e){
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
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ),
          Container(
            height: 300.0,
            color: Colors.white,
              padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                    onChanged: (text) {
                      setState(() =>  rideRequest.request['currentLocation'] = text);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Current Location',
                        prefixIcon:
                            Icon(Icons.location_on, color: Colors.black),
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
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        onChanged: (text) {
                          
                          setState(() =>  rideRequest.request['destination'] = text);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: 'Destination',
                            prefixIcon:
                                Icon(Icons.directions_car, color: Colors.black),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0) ),
                padding: EdgeInsets.only(top: 15.0,left: 20.0, right: 20.0),
                
                height: 50.0,
                child:
                 Container(
                  height: 40.0,
                  width: 200.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.amberAccent,
                    color: Colors.amber,
                    elevation: 7.0,
                    child: GestureDetector(
                        onTap: () {
                                     //print('$source  $destination'); */
                     rideRequest.save();
                    Navigator.of(context).pushNamed("/DriverProfile");
              
                        },
                         child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Request A Ride",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold))
                                    )
                                    ),

                //  RaisedButton(
                //   color: Colors.black,
                //   onPressed: () {
                //     /* print('$source  $destination'); */
                //   rideRequest.save();
                //   Navigator.of(context).pushNamed("/DriverProfile");
                //   },
                //   child: Text('Request A Ride', style: TextStyle(color: Colors.white),)
                // ),
                 
                 )
                 )
                     )
                ],
              )
              ),
              
        ],
      )
      ),
    );


  }

    
      _read() async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'isLoggedIn';
        final value = prefs.getStringList(key);
         return value;
    }
}