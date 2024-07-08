import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wshopper/globals.dart';
import 'package:wshopper/screens/cartpage.dart';
import 'package:wshopper/screens/productlistpage.dart';
import 'package:wshopper/services/tumbi_api.dart';
import 'package:wshopper/viewmodels/cart.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => Cart(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'WShopper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future getProduts;
  @override
  void initState() {
    super.initState();
    getProduts = ApiService().fetchProducts();
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProduts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(currentPage == 0 ? "WShopper" : "Cart"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Badge.count(
                      count: Provider.of<Cart>(
                        context,
                      ).cart.length,
                      child: const Icon(Icons.shopping_cart),
                    ),
                  )
                ],
              ),
              body: [
                ProductPage(products: snapshot.data),
                const CartPage()
              ][currentPage],
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(183, 33, 149, 243),
                      Color.fromARGB(108, 33, 149, 243),
                    ]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              currentPage = 0;
                            });
                          },
                          icon: Icon(Icons.home,
                              color: currentPage == 0
                                  ? Colors.white
                                  : Colors.black26),
                          label: Text(
                            "Home",
                            style: TextStyle(
                                color: currentPage == 0
                                    ? Colors.white
                                    : Colors.black26),
                          )),
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              currentPage = 1;
                            });
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: currentPage == 1
                                ? Colors.white
                                : Colors.black26,
                          ),
                          label: Text(
                            "Cart",
                            style: TextStyle(
                                color: currentPage == 1
                                    ? Colors.white
                                    : Colors.black26),
                          ))
                    ],
                  ),
                ),
              ),
             
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
