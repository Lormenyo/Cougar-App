import 'package:http/http.dart' as http;
// import 'package:firebase_database/firebase_database.dart';



// final databaseReference = FirebaseDatabase.instance.reference();



class RideRequest {

  static String firstName = '';
  static String phoneNumber = '';
  static String currentLocation = '';
  static String destination = '';
  String url;

  Map request = {
    firstName: false,
    phoneNumber: false,
    currentLocation: false,
    destination :false
  };
 
  save() async {
    // url = 'http://10.0.2.2:5000/api?firstName=Hannah&phoneNumber=233266180856';
    print(request['firstName']);
    try {
    url = 'https://kugar.herokuapp.com/rideRequest';
    
    http.Response response = await http.post(url, body: {
      'firstName': request['firstName'],
      'phoneNumber':request['phoneNumber'],
      'currentLocation': request['currentLocation'],
      'destination': request['destination']
    });
    print('saving user using a web service');
  //   databaseReference.child("1").set({
  //   'firstName': user['firstName'],
  //   'phoneNumber': user['phoneNumber']
  // });
    return response.body;
    }
    catch (e){
      print(e);
    //  url = 'https://kugar.herokuapp.com/rideRequest';
    
    // http.Response response = await http.post(url, body: {
    //   'firstName': request['firstName'],
    //   'phoneNumber':request['phoneNumber'],
    //   'currentLocation': request['currentLocation'],
    //   'destination': request['destination']
    // });
    // print('saving user using a web service');
    // return response.body;
    }
  }
}
