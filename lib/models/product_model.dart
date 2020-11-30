import 'package:flutter/material.dart';

class Product {
  final String name, description;
  final double rating, price;
  final bool isPopular, isFavourite;
  List<dynamic> images;
  final List<Color> colors;
  final List<String> categories;
  final String id;

  Product({
    @required this.name,
    @required this.images,
    @required this.price,
    this.rating = 0.0,
    @required this.description,
    this.colors = const [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
      Colors.transparent,
    ],
    this.isPopular = false,
    this.isFavourite = false,
    this.id,
    this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'rating': rating.toString(),
      'price': price.toString() ?? "0.0",
      'isPopular': isPopular,
      'isFavourite': isFavourite,
      'images': images,
      'categories': categories,
      'id': id
    };
  }

  static Product fromMap(Map<String, dynamic> map, docId) {
    if (map == null) return null;
    return Product(
      name: map['name'] ?? "",
      images: List<dynamic>.from(map['images']) ?? [""],
      price: double.parse(map['price']) ?? 0.0,
      rating: double.parse(map['rating']) ?? 0.0,
      description: map['description'] ?? "",
      categories: List<String>.from(map['categories']) ?? [""],
      isPopular: map['isPopular'] ?? false,
      isFavourite: map['isFavourite'] ?? false,
      id: docId,
    );
  }
}

String description =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation";

List<Product> myProducts = [
  Product(
    id: "1",
    name: "Wireless Controller for PS4",
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
      Colors.transparent,
    ],
    price: 64.99,
    rating: 4.8,
    isPopular: true,
    isFavourite: true,
    categories: ["1"],
    description: description,
  ),
  Product(
    id: "2",
    name: "Nike Sport White Men Pant",
    images: ["assets/images/Image Popular Product 2.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
      Colors.transparent,
    ],
    price: 50.99,
    rating: 4.1,
    isPopular: true,
    categories: ["2"],
    description: description,
  ),
  Product(
    id: "3",
    name: "Gloves XC Omega - Polygon",
    images: ["assets/images/glap.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
      Colors.transparent,
    ],
    price: 36.55,
    rating: 4.1,
    isPopular: true,
    isFavourite: true,
    categories: ["3"],
    description: description,
  ),
  Product(
    id: "4",
    name: "Sharp Helmet",
    images: ["assets/images/Image Popular Product 3.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
      Colors.transparent,
    ],
    price: 20.99,
    rating: 2.1,
    isFavourite: true,
    categories: ["4"],
    description: description,
  ),
  Product(
    id: "5",
    name: "Logitech HeadSet",
    images: ["assets/images/wireless headset.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
      Colors.transparent
    ],
    price: 10.99,
    rating: 3.8,
    isFavourite: true,
    categories: ["4"],
    description: description,
  ),
];
