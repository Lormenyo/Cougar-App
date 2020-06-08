import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:getflutter/getflutter.dart';
import "dart:convert";
import 'dart:async';
import './service/service_locator.dart';
import './service/call_service.dart';

StreamController<Future<List<dynamic>>> streamController =
    new StreamController();

class Requests extends StatefulWidget {
  _RequestState createState() => new _RequestState();
}

class _RequestState extends State<Requests> {
  final String url = 'https://kugar.herokuapp.com/getRideRequest';
  List data;
  final CallService _service = locator<CallService>();
  int number = 1;

  @override
  void initState() {
    super.initState();

    streamController.add(this.getJsonData());
    print("code controller is here");

    print("Creating a StreamController...");
    streamController.stream.listen((data) {
      return data;
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });

    final duration = Duration(seconds: number);
    Timer.periodic(duration, (Timer t) => streamController.add(this.getJsonData()));
  }

  @override
  void dispose() {
    streamController.close(); //Streams must be closed when not needed
    super.dispose();
  }

  Future<List> getJsonData() async {
    var response = await http.get(
        // encode the url to remove spaces
        Uri.encodeFull(url),
        // Accept only json data
        headers: {"Accept": "application/json"});
    // print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['Requests'];
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: new Text("Ride Requests"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            color: Colors.grey[100],
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GFListTile(
                    color: Colors.white60,
                    titleText: data[index]['name'],
                    subtitleText: data[index]['currentLocation'].toString() +
                        " to " +
                        data[index]['destination'].toString(),
                    icon: GFIconButton(
                      color: GFColors.WARNING,
                      icon: Icon(Icons.phone),
                      onPressed: () => /* showDialog(
                        context: context,
                        builder: (context) {
                          return Callme(
                            number: data[index]['phoneNumber'],
                          );
                        },
                      ), */
                      _service.call(data[index]['phoneNumber']),
                      padding: EdgeInsets.all(10.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void call(String number) => launch("tel:$number");
}

// class Callme extends StatelessWidget {
//   Callme({this.number});
//   final String number;
  
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(number),
//     );
//   }
// }
