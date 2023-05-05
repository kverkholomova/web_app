
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:web_app/card_planet.dart';
import 'package:web_app/models/card_planet_data.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  final data = [
    CardPlanetData(
        title: "Add your application",
        subtitle: "Simply fill in the details of your request and wait for a volunteer to accept an application and assist you.",
        image: AssetImage("assets/1.jpg"),
        titleColor: Colors.white,
        backgroundColor: Colors.black,
        subtitleColor: Colors.indigoAccent),
    CardPlanetData(
        title: "Add your application",
        subtitle: "Simply fill in the details of your request and wait for a volunteer to accept an application and assist you.",
        image: AssetImage("assets/2.jpg"),
        titleColor: Colors.white,
        backgroundColor: Colors.red,
        subtitleColor: Colors.indigoAccent),
    CardPlanetData(
        title: "Add your application",
        subtitle: "Simply fill in the details of your request and wait for a volunteer to accept an application and assist you.",
        image: AssetImage("assets/8.jpg"),
        titleColor: Colors.white,
        backgroundColor: Color.fromRGBO(5, 4, 36, 25),
        subtitleColor: Colors.indigoAccent),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ConcentricPageView(
      colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: 3, // null = infinity
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
      ),
        
      ),
    );
  }
}
