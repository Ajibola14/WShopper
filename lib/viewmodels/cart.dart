import 'dart:async';

import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/products.dart';

class Cart extends ChangeNotifier {
  List<Map<String, dynamic>> cart = [];

  void addToCart(Product product) {
    // Check if the product is already in the cart
    bool found = false;
    for (Map<String, dynamic> item in cart) {
      if (item.containsValue(product.name)) {
        found = true;
        break;
      }
    }

    // Add the product if it was not found in the cart
    if (!found) {
      cart.add({
        "product": product,
        "productName": product.name,
        "price": product.price
      });
    } else {

      final messenger = scaffoldMessengerKey.currentState;
      messenger?.showMaterialBanner(
        MaterialBanner(
          content: const Text('Product Already in cart!'),
          actions: [
            TextButton(
              onPressed: () {
                messenger.hideCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
      Timer(const Duration(seconds: 2), () {
        messenger?.hideCurrentMaterialBanner();
      });
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    cart.removeWhere((element) => element["product"] == product);
    notifyListeners();
  }

  int _totalCost() {
    int cost = 0;
    for (var item in cart) {
      cost += item["price"] as int;
    }
    return cost;
  }

  int get totalCost => _totalCost();
}
