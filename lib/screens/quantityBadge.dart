import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fruit_salad/providers/CartProvider.dart';
import 'package:fruit_salad/fruit.dart';

class QuantityBadge extends StatelessWidget {
  const QuantityBadge({
    super.key,
    required this.selectedFruit,
  });

  final Fruit selectedFruit;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
          color: Colors.red),
      padding: const EdgeInsets.only(left: 6, right: 6, top: 1, bottom: 1),
      child: Text((cart.list[selectedFruit.name] ?? 0).toString(),
          style: const TextStyle(color: Colors.white)),
    );

    /*return RichText(
      text: TextSpan(
        text: (cart.list[selectedFruit.name] ?? 0).toString(),
        style: const TextStyle(
            backgroundColor: Colors.red,
            color: Colors.white,
            decoration:
      ),
    );*/
  }
}
