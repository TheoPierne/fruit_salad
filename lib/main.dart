import 'package:flutter/material.dart';
import 'package:fruit_salad/providers/CartProvider.dart';
import 'package:fruit_salad/screens/fruitdetailsscreen.dart';
import 'package:fruit_salad/screens/cartScreen.dart';
import 'package:fruit_salad/screens/fruitpreview.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit App Théo Pierné',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FruitsMaster(
              title: "Total panier: <N>€",
            ),
        '/detail': (context) => const FruitDetailsScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  final List<String> filters = ['Tout', 'Printemps', 'Eté', 'Automne', 'Hiver'];
  late String currentFilter = filters.first;

  void updateListView(String filter) {}

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
            widget.title.replaceAll('<N>', cart.totalPrice.toStringAsFixed(2))),
        automaticallyImplyLeading: false,
        actions: [
          DropdownButton<String>(
            value: currentFilter,
            icon: const Icon(Icons.menu),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              setState(() {
                currentFilter = value!;
              });
              updateListView(value!);
            },
            items: filters.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Panier',
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cart.getListOfFruitBySeason(currentFilter).length,
        itemBuilder: (context, index) {
          return FruitPreview(
            fruit: cart.getListOfFruitBySeason(currentFilter)[index],
          );
        },
      ),
    );
  }
}
