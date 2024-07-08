import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/products.dart';
import 'dart:async';

class Cart extends ChangeNotifier {
  List<Product> cart = [];

  bool inCart(Product product) {
    for (Product item in cart) {
      if (item == product) {
        return true;
      }
    }
    return false;
  }

  void addToCart(Product product) {
    if (!inCart(product)) {
      cart.add(product);
      final messenger = scaffoldMessengerKey.currentState;
      messenger?.showMaterialBanner(
        MaterialBanner(
          content: const Text('Product added to cart!'),
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
    cart.removeWhere((element) => element == product);
    notifyListeners();
  }

  double _totalCost() {
    double cost = 0;
    for (var item in cart) {
      cost += item.price;
    }
    return cost;
  }

  double get totalCost => _totalCost();
}
