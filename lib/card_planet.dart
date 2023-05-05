import 'package:flutter/material.dart';
import 'package:web_app/models/card_planet_data.dart';

class CardPlanet extends StatelessWidget {

  CardPlanet({required this.data, Key? key}) : super(key: key);
  final CardPlanetData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 400,
            width: 400,
            child: Image(image: data.image)),

      ],
    );
  }
}
