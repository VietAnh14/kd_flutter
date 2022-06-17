
import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/services/remote/product_api.dart';

class ProductVM extends ChangeNotifier {
  final ProductApi api;
  var products = List.empty(growable: true);
  ProductVM(this.api);

  void getProductList() async {
    products = await api.getProductList();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}