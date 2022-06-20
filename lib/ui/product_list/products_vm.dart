
import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/services/remote/product_api.dart';

class ProductVM extends ChangeNotifier {
  final ProductApi api;
  var products = List<Product>.empty(growable: true);
  var isLoading = false;
  ProductVM(this.api) {
    getProductList();
  }

  void getProductList() async {
    try {
      _setIsLoading(true);
      await Future.delayed(const Duration(seconds: 4));
      products = await api.getProductList();
      _setIsLoading(false);
      notifyListeners();
    } catch (e) {
      _setIsLoading(false);
      print(e);
    }
  }

  void searchProduct(String query) {

  }

  void _setIsLoading(bool reload) {
    isLoading = reload;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}