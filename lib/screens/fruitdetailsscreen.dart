import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fruit_salad/providers/CartProvider.dart';
import 'package:fruit_salad/screens/quantityBadge.dart';
import 'package:provider/provider.dart';

class FruitDetailsScreen extends StatelessWidget {
  const FruitDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(cart.selectedFruit.name),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
          tooltip: 'Retour au shop',
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: cart.selectedFruit.image,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            'Origine: ${cart.selectedFruit.origin['name']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Saison: ${cart.selectedFruit.season}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Stock: ${cart.selectedFruit.stock}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            'Tarif à l\'unité: ${cart.selectedFruit.price}€'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Text('Quantité sélectionnée:  '),
                            QuantityBadge(
                              selectedFruit: cart.selectedFruit,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.blue),
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                          ),
                          onPressed: () {
                            cart.add(cart.selectedFruit);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${cart.selectedFruit.name} ajoutés(s)',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 1500),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                          ),
                          onPressed: () {
                            cart.remove(cart.selectedFruit);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${cart.selectedFruit.name} retiré(s)',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 1500),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: SizedBox(
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                          double.parse(cart.selectedFruit
                              .origin['location']['coordinates'][1]
                              .toStringAsFixed(6)),
                          double.parse(cart.selectedFruit
                              .origin['location']['coordinates'][0]
                              .toStringAsFixed(6))),
                      zoom: 13.0,
                    ),
                    nonRotatedChildren: [
                      AttributionWidget.defaultWidget(
                        source: 'OpenStreetMap contributors',
                        onSourceTapped: null,
                      ),
                    ],
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                                double.parse(cart.selectedFruit
                                    .origin['location']['coordinates'][1]
                                    .toStringAsFixed(6)),
                                double.parse(cart.selectedFruit
                                    .origin['location']['coordinates'][0]
                                    .toStringAsFixed(6))),
                            width: 60,
                            height: 60,
                            builder: (context) => Column(
                              children: [
                                const Image(
                                  width: 40,
                                  height: 40,
                                  image: AssetImage('assets/images/marker.png'),
                                ),
                                Text(
                                  "${cart.selectedFruit.origin['name']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
