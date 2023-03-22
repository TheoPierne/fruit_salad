import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fruit_salad/fruit.dart';

import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {
  final Map<String, int> _cart = {};
  final List<Fruit> _fruitList = [];
  late Fruit _selectedFruit;

  CartProvider() {
    fetchFruitList();
  }

  Future<void> fetchFruitList() async {
    final response = await http
        .get(Uri.parse('https://fruits.shrp.dev/items/fruits?fields=*.*'));

    if (response.statusCode == 200) {
      final fruits = jsonDecode(response.body);
      final List<Fruit> fruitList = [];
      for (var fruit in fruits['data']) {
        fruitList.add(Fruit.fromJson(fruit));
      }
      setFruitsList(fruitList);
      notifyListeners();
    } else {
      throw Exception('Failed to load fruit list');
    }
  }

  UnmodifiableMapView<String, int> get list => UnmodifiableMapView(_cart);
  num get totalPrice => _cart.entries.fold<num>(
      0,
      (previousValue, element) =>
          previousValue +
          _fruitList.firstWhere((fruit) => fruit.name == element.key).price *
              element.value);

  UnmodifiableListView<Fruit> get fruitsList =>
      UnmodifiableListView(_fruitList);

  Fruit get selectedFruit => _selectedFruit;

  void setSelectedFruit(Fruit fruit) {
    _selectedFruit = fruit;
    notifyListeners();
  }

  void setFruitsList(List<Fruit> listFruits) {
    _fruitList.clear();
    _fruitList.addAll(listFruits);
    notifyListeners();
  }

  UnmodifiableListView<Fruit> getListOfFruitBySeason(String season) {
    if (season == 'Tout') return UnmodifiableListView(_fruitList);
    return UnmodifiableListView(_fruitList.where((e) => e.season == season));
  }

  void add(Fruit fruit) {
    if (_cart.containsKey(fruit.name)) {
      _cart[fruit.name] = _cart[fruit.name]! + 1;
    } else {
      _cart[fruit.name] = 1;
    }
    notifyListeners();
  }

  void remove(Fruit fruit) {
    if (_cart.containsKey(fruit.name) && _cart[fruit.name]! - 1 == 0) {
      _cart.remove(fruit.name);
    } else if (_cart.containsKey(fruit.name)) {
      _cart[fruit.name] = _cart[fruit.name]! - 1;
    }
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _cart.clear();
    notifyListeners();
  }
}
