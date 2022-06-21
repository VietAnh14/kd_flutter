import 'package:flutter_kd/services/remote/model/product.dart';

class EditProductResponse {
  int? id;
  String? image;
  String? price;
  String? productName;
  String? quantity;
  String? sku;
  String? status;
  String? unit;
  bool? success;
  String? message;
  dynamic data;

  EditProductResponse({
    required this.id,
    this.image,
    required this.quantity,
    required this.price,
    required this.productName,
    required this.sku,
    required this.status,
    required this.unit,
    this.success,
    this.message,
    this.data,
  });

  factory EditProductResponse.fromJson(Map<String, dynamic> json) {
    return EditProductResponse(
      id: json['id'],
      quantity: json['qty'],
      price: json['price'],
      productName: json['product_name'],
      sku: json['sku'],
      status: json['status'],
      unit: json['unit'],
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Product toProduct() {
    return Product(
        id: id!,
        quantity: int.parse(quantity!),
        price: int.parse(price!),
        productName: productName!,
        sku: sku!,
        status: int.parse(status!),
        unit: unit!
    );
  }
}