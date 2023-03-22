import 'package:flutter/material.dart';
import 'package:fruit_salad/fruit.dart';
import 'package:fruit_salad/providers/CartProvider.dart';
import 'package:fruit_salad/screens/quantityBadge.dart';
import 'package:provider/provider.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview({
    super.key,
    required this.fruit,
  });

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return ListTile(
      title: Text(fruit.name),
      tileColor: fruit.color,
      leading: CircleAvatar(
        backgroundImage: fruit.image,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuantityBadge(
            selectedFruit: fruit,
          ),
          IconButton(
            hoverColor: const Color.fromARGB(200, 201, 200, 199),
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () =>
                Provider.of<CartProvider>(context, listen: false).add(fruit),
          ),
        ],
      ),
      onTap: () {
        Provider.of<CartProvider>(context, listen: false)
            .setSelectedFruit(fruit);
        Navigator.pushNamed(context, '/detail');
      },
    );
  }
}
