import "package:flutter/material.dart";

class DriverProfile extends StatefulWidget {
  _DriverProfileState createState() => new _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.9)),
          clipper: GetClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      image: DecorationImage(
                          image: AssetImage("assets/images/driverprofile.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                SizedBox(height: 60.0),
                Text(
                  "ERNEST",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(left:30.0, top: 5.0),
                  child:Card(
                  elevation: 30.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.call, size: 50),
                        title: Text('+233244778099'),
                        subtitle: Text(' CALL'),
                      ),
                      Container(height: 15.0, decoration: BoxDecoration(color: Colors.black12),),
                      const ListTile(
                        leading: Icon(Icons.euro_symbol, size: 50),
                        title: Text('GHC 50.00'),
                        subtitle: Text('Pay in Cash'),
                      ),
                    ],
                  ),
                )
                ),
                Container(height: 20.0, decoration: BoxDecoration(color: Colors.white10),),
                 Container(
                   padding: const EdgeInsets.only(left:30.0),
                  height: 40.0,
                  width: 300.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.black12,
                    color: Colors.black,
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
                  )
                 )
              ],
            ))
      ],
    ));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 2.0);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
