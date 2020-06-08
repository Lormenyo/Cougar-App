// List of registered taxi drivers

import 'package:flutter/material.dart';
import 'dart:async';
import './service/service_locator.dart';
import './service/call_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getflutter/getflutter.dart';
import "package:http/http.dart" as http;
import "dart:convert";


StreamController<Future<List<dynamic>>> streamController =
    new StreamController();

class OffCampus extends StatefulWidget{
  @override 
  _OffCampus createState () => new _OffCampus();
}

class _OffCampus extends State<OffCampus> {

  final String url = 'https://kugar.herokuapp.com/getRideRequest';
  List data;
  final CallService _service = locator<CallService>();

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
    getJsonData().then((value){
          data = value;
    });
    return Scaffold(
      appBar: AppBar(
        title: new Text("Get A Driver"),
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
                    avatar:GFAvatar(),
                    color: Colors.white60,
                    titleText: data[index]['name'],
                    subtitleText: data[index]['currentLocation'].toString() +
                        " to " +
                        data[index]['destination'].toString(),
                    icon: GFIconButton(
                      color: GFColors.WARNING,
                      icon: Icon(Icons.phone),
                      onPressed: () => 
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