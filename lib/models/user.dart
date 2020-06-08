// import '../api.dart' ;
import 'package:http/http.dart' as http;
// import 'package:firebase_database/firebase_database.dart';



// final databaseReference = FirebaseDatabase.instance.reference();


class User {

  static String firstName = '';
  static String phoneNumber = '';
  static String typeOfUser = '';
  static String code = '';
  String url;

  Map user = {
    firstName: false,
    phoneNumber: false,
    typeOfUser: false,
    code:false
  };
 
  save() async {
    // url = 'http://10.0.2.2:5000/api?firstName=Hannah&phoneNumber=233266180856';
    print(user['firstName']);
    try {
    url = 'https://kugar.herokuapp.com/api';
    http.Response response = await http.post(url, body: {
      'firstName': user['firstName'],
      'phoneNumber':user['phoneNumber'],
      'typeOfUser': user['typeOfUser'],
      'code': user['code']
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
      url = 'https://kugar.herokuapp.com/api?firstName=Hannah&phoneNumber=233266180856';
    http.Response response = await http.get(url);
    print('saving user using a web service');
    return response.body;
    }
  }
}
