import 'package:flutter/material.dart';
import 'package:fruit_salad/providers/CartProvider.dart';
import 'package:fruit_salad/screens/loginHandler.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const Text('Panier'),
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_sharp),
            tooltip: 'Retour au shop',
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Retirer tout les fruits du panier',
              onPressed: () {
                cart.removeAll();
              },
            ),
          ],
        ),
        body: cart.list.isEmpty
            ? const Center(
                child: Text(
                  'Aucun fruit dans le panier !',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: cart.list.length,
                      itemBuilder: (context, index) {
                        String key = cart.list.keys.elementAt(index);
                        return ListTile(
                          title: Text(
                              "$key (${cart.fruitsList.firstWhere((element) => element.name == key).price * cart.list[key]!}€)"),
                          trailing: IconButton(
                            hoverColor: Colors.red,
                            icon: const Icon(Icons.delete),
                            onPressed: () => cart.remove(cart.fruitsList
                                .firstWhere((element) => element.name == key)),
                          ),
                        );
                      },
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: LoginHandler(),
                  ),
                ],
              ));
  }
}
