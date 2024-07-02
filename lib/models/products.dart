class Product {
  final String name;
  final int price;
  final String image;
  final String description;

  const Product(
      {required this.name,
      required this.price,
      required this.image,
      required this.description});
  factory Product.fromMap(Map map) {
    return Product(
        name: map["name"],
        price: map["price"],
        image: map["image"],
        description: map["description"]);
  }
}
