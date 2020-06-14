// List of registered taxi drivers

import 'package:flutter/material.dart';
import 'dart:async';
import './service/service_locator.dart';
import './service/call_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getflutter/getflutter.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


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

  @override
  void initState(){
    super.initState();
    this.getJsonData();
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
    // getJsonData().then((value){
    //       data = value;
    // });
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

    return Scaffold(

      body: _scrollableView(context)
    );
  }
  void call(String number) => launch("tel:$number");


Widget _scrollableView(BuildContext context){
return CustomScrollView(
  slivers: <Widget>[
    SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 10.0,
      flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Get a Driver",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.asset(
                      "assets/images/cougar-c.jpg",
                      fit: BoxFit.cover,
                      // color: Colors.black,
                    )),
      // title: Text("Get A driver",
      // textAlign: TextAlign.center,
      // style: GoogleFonts.openSans(
      //   color: Colors.white
      // ),),
      pinned: true,
      expandedHeight: 150,),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) =>
           _buildTile(context, data[index]['name'], data[index]["phoneNumber"]),
           childCount: data == null ? 0 : data.length
        )
         
      ),
    

  ],
);
}

Widget _buildTile(BuildContext context, String name, String phoneNumber){
  return  GFListTile(
                    avatar:GFAvatar(),
                    color: Colors.white60,
                    titleText: name,
                    subtitleText: "",
                    icon: GFIconButton(
                      color: GFColors.WARNING,
                      icon: Icon(Icons.phone),
                      onPressed: () => 
                      _service.call(phoneNumber),
                      padding: EdgeInsets.all(10.0),
                    ),
                  );
}

}