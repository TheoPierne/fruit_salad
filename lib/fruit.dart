import 'package:flutter/material.dart';
import 'package:fruit_salad/utils/hexColor.dart';

class Fruit {
  final int id;
  final String name;
  final Color color;
  final num price;
  final AssetImage image;
  final List<dynamic> coordinates;

  const Fruit(
    this.id,
    this.name,
    this.color,
    this.price,
    this.image,
    this.coordinates,
  );

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
        json['id'],
        json['name'],
        HexColor(json['color']),
        json['price'],
        AssetImage("assets/images/${json['image']}"),
        json['origin']['location']['coordinates']);
  }
}
