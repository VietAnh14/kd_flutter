
import 'dart:convert';

class Product {
  int id;
  String? image;
  int price;
  String productName;
  int quantity;
  String sku;
  int status;
  String unit;

  Product({
    required this.id,
    this.image,
    required this.quantity,
    required this.price,
    required this.productName,
    required this.sku,
    required this.status,
    required this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      quantity: json['qty'],
      price: json['price'],
      productName: json['product_name'],
      sku: json['sku'],
      status: json['status'],
      unit: json['unit'],
    );
  }

  static List<Product> fromJsonList(List products) {
    return products.map((e) => Product.fromJson(e)).toList();
  }
}
