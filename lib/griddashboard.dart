import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  final Items item1 = new Items(
      title: "Campus Rides",
      subtitle: "Rides to anywhere on campus",
      event: "",
      img: "assets/images/campus.png",
      route: "/Map");

  final Items item2 = new Items(
    title: "Off Campus Rides",
    subtitle: "Rides outside of campus eg. Accra",
    event: "",
    img: "assets/images/town.jpg",
    route: "/OffCampus"
  );

  final Items item3 = new Items(
    title: "School Bus Services",
    subtitle: "Reserve a seat on the school bus",
    event: "",
    img: "assets/images/bus.png",
    route: ""
  );
  
  final Items item4 = new Items(
    title: "Make a report",
    subtitle: "Send feedback about the app",
    event: "",
    img: "assets/images/report.png",
    route: "/Report"
  );
  
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              child: Container(
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.event,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            onTap: () {
             Navigator.pushNamed(context, data.route); 
            },
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  String route;
  Items({this.title, this.subtitle, this.event, this.img, this.route});
}