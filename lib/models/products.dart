// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String name;
  double price;
  String image;
  String description;

  Product(
    this.name,
    this.price,
    this.image,
    this.description,
  );
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['name'] as String,
      map['current_price'][0]["NGN"][0] as double,
      map['photos'][0]["url"] as String,
      map['description'] as String,
    );
  }

  Product copyWith({
    String? name,
    double? price,
    String? image,
    String? description,
  }) {
    return Product(
      name ?? this.name,
      price ?? this.price,
      image ?? this.image,
      description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, price: $price, image: $image, description: $description)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.price == price &&
        other.image == image &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        price.hashCode ^
        image.hashCode ^
        description.hashCode;
  }
}
