// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wshopper/models/products.dart';
import 'package:wshopper/viewmodels/cart.dart';

class ProductPage extends StatefulWidget {
  final List<Product> products;
  const ProductPage({
    super.key,
    required this.products,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => GridView.builder(
        itemCount: widget.products.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: MediaQuery.of(context).size.height * 0.3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          Product product = widget.products[index];
          bool foundInCart = value.inCart(product);
          return GestureDetector(
            onDoubleTap: () {
              if (foundInCart) {
                value.removeFromCart(product);
              } else {
                value.addToCart(product);
              }
            },
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: Image.network(
                              "https://api.timbu.cloud/images/${product.image}"),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              foundInCart
                                  ? value.removeFromCart(product)
                                  : value.addToCart(product);
                              Navigator.of(context).pop();
                            },
                            color: foundInCart ? Colors.white70 : Colors.blue,
                            textColor: foundInCart ? Colors.blue : Colors.white,
                            child: Text(foundInCart
                                ? "Remove from Cart"
                                : "Add to Cart"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: value.inCart(product)
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: Image.network(
                        "https://api.timbu.cloud/images/${product.image}",
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("₦ ${product.price}"),
                      IconButton(
                          onPressed: () {
                            foundInCart
                                ? value.removeFromCart(product)
                                : value.addToCart(product);
                          },
                          color: foundInCart ? Colors.blue : Colors.black,
                          icon: Icon(foundInCart ? Icons.remove : Icons.add))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
