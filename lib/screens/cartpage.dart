import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wshopper/main.dart';
// ignore: unused_import
import 'package:wshopper/screens/productlistpage.dart';
import 'package:wshopper/viewmodels/cart.dart';

import '../models/products.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(108, 194, 222, 244),
      child: Consumer<Cart>(
        builder: (context, value, child) {
          return value.cart.isEmpty
              ? const Center(
                  child: Text("Cart is Empty"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.cart.length,
                        itemBuilder: (context, index) {
                          Product product = value.cart[index];
                          return ListTile(
                            leading: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Image.network(
                                "https://api.timbu.cloud/images/${product.image}",
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            title: Text(product.name),
                            subtitle: Text("${product.price}"),
                            trailing: CloseButton(
                              onPressed: () {
                                value.removeFromCart(product);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Total : ₦${value.totalCost}"),
                              MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        "Successful Checkout",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      content: const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.green,
                                          child: Icon(Icons.check)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              value.cart = [];
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen(),
                                              ));
                                            },
                                            child: const Text(
                                              "Finish",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Purchase",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ]))
                  ],
                );
        },
      ),
    );
  }
}
