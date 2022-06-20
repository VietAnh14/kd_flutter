import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/add_product_request.dart';
import 'package:flutter_kd/services/remote/product_api.dart';

import '../services/remote/model/product.dart';

class ProductDetailVM extends ChangeNotifier {
  ProductApi _api;
  late Product product;
  bool isLoading = false;
  late bool isEditing = false;

  ProductDetailVM(this._api, Product? product) {
    this.product = product ?? Product.empty();
    this.isEditing = product != null;
  }

  void _validateProduct() {

  }

  void skuChange(String sku) {
    product.sku = sku;
    _validateProduct();
  }

  void nameChange(String name) {
    product.productName = name;
    _validateProduct();
  }

  void priceChange(double price) {
    product.price = price;
    _validateProduct();
  }

  void unitChange(String unit) {
    product.unit = unit;
    _validateProduct();
  }

  void statusChange(int status) {
    product.status = status;
    _validateProduct();
  }

  void addProduct() async {
    try {
      final request = AddProductRequest.fromProduct(product);
      final newProduct = _api.addProduct(request);

    } catch (e) {
      print(e);
    }
  }
}