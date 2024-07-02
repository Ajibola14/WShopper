import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wshopper/models/products.dart';
import 'package:wshopper/viewmodels/cart.dart';
import '../productlist.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: iPhones.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          Product product = Product.fromMap(iPhones[index]);
          return Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.15,
                margin: const EdgeInsets.only(right: 5),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        product.description,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₦${product.price}"),
                          GestureDetector(
                            onTap: () {
                              value.addToCart(product);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    gradient: LinearGradient(colors: [
                                      Color.fromARGB(183, 33, 149, 243),
                                      Color.fromARGB(108, 33, 149, 243),
                                    ])),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      )
                    ]),
              )
            ],
          );
        },
      ),
    );
  }
}
