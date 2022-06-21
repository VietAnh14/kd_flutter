
import 'package:flutter_kd/services/remote/model/product.dart';

class AddProductRequest {
  final String sku;
  final String productName;
  final int qty;
  final int price;
  final String unit;
  final int status;

  AddProductRequest({
    required this.sku,
    required this.productName,
    required this.qty,
    required this.price,
    required this.unit,
    required this.status
  });

  factory AddProductRequest.fromProduct(Product product) {
    return AddProductRequest(
        sku: product.sku,
        productName: product.productName,
        qty: product.quantity,
        price: product.price,
        unit: product.unit,
        status: product.status
    );
  }

  Map<String, dynamic> toJsonRequest() => {
    "sku": sku,
    "product_name": productName,
    "qty": qty,
    "price": price,
    "unit": unit,
    "status": status
  };
}