import 'package:cougar/driver.dart';
import 'package:cougar/requests.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'offcampus.dart';
import 'package:splashscreen/splashscreen.dart';
import 'driver_registration.dart';
import 'map.dart';
import 'student_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './service/service_locator.dart';
import 'welcome.dart';
import 'report.dart';



void main() {
   setupLocator();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
        title: 'Kugar',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          // backgroundColor: Colors.white
        ),

        routes: <String, WidgetBuilder> {
          "/RegisterStudent": (BuildContext context) => new StudentRegister(),
          "/RegisterDriver": (BuildContext context) => new DriverRegister(),
          "/Map": (BuildContext context) => new MyMap(),
          "/Requests": (BuildContext context) => new Requests(),
          "/DriverProfile": (BuildContext context) => new DriverProfile(),
          "/Welcome": (BuildContext context) => new Welcome(),
          "/OffCampus": (BuildContext context) => new OffCampus(),
          "/Report": (BuildContext context) => new Report(),
          // "/Visa": (BuildContext context) => new Visa() 
        }
        

  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
 String userLoggedIn = '0';
 String user;
 String phoneNumber;

  @override
  Widget build(BuildContext context) {
     
    _read().then((value){
      try{
      setState(() => userLoggedIn = value[0]);
      setState(() => user =  value[1]);
      setState(() => phoneNumber =  value[2]);
      }
      catch(e){
        print(e);
      }
    });
    print(userLoggedIn);
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: userLoggedIn == '1' ?  new Welcome() : userLoggedIn == '2' ?  new Requests(): new AfterSplash(),
      //  if userLogged ==1 , then student is logged in
      // if userLogged == 2, then driver is logged in
      // if userlogged == 0 , then no user is logged in
      title: new Text(
        'KUGAR',
        textAlign: TextAlign.center,
        style: new TextStyle(
          letterSpacing: 2.1,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            // fontStyle: FontStyle.italic
            ),
      ),
      image: new Image.asset('assets/images/cougar.gif',
          alignment: Alignment.center),
 /*      gradientBackground: new LinearGradient(colors: [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white,Colors.amber], begin: Alignment.topLeft, end: Alignment.bottomCenter), */
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
    
  }

  
      _read() async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'isLoggedIn';
        print("prefs" + prefs.getStringList(key).toString());
        if (prefs.getStringList(key) == null){
          final value = ['0', null, null];
          return value;
        }
        else{
          final value = prefs.getStringList(key);
          return value;
        }
    }
}

class AfterSplash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Kugar');   
  }
}
  


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      Center(
        child: new Image.asset(
          'assets/images/cougar-b.jpg',
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 520.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text("Kugar",
                    style: TextStyle(
                      letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white)),
              ),
              Center(
                child: Text("The fastest way to your destination...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18.0,
                        color: Colors.white)),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 0),
                  child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                  height: 35,
                  width: 100,
                  child: RaisedButton(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.yellow)),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/RegisterDriver");
                          },
                          child: const Text('Driver',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        )
                        ),
                        Container(
                  height: 35,
                  width: 120,
                  child:RaisedButton(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.yellow)),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/RegisterStudent");
                          },
                          child: const Text('Student',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        )
                        )
                      ]
                      )
                      )
            ],
          ))
    ]
    )
    );
  }
}




