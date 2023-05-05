import 'package:flutter/cupertino.dart';

class CardPlanetData{
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color titleColor;
  final Color backgroundColor;
  final Color subtitleColor;

  const CardPlanetData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.titleColor,
    required this.backgroundColor,
    required this.subtitleColor
});
}

