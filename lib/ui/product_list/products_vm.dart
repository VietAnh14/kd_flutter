import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/services/remote/product_api.dart';

class ProductVM extends ChangeNotifier {
  final ProductApi api;
  var products = List<Product>.empty(growable: true);
  bool isLoading = false;
  bool isDispose = false;
  CancelableOperation? searchOperation;

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

  void onQueryChange(String query) {
    searchOperation?.cancel();
    searchOperation = CancelableOperation.fromFuture(Future.delayed(Duration(seconds: 1)))
        .then((aVoid) => searchProduct(query));
  }

  Future<void> searchProduct(String query) async {
    try {
      _setIsLoading(true);
      final product = await api.searchProduct(query);
      products = [product];
      _setIsLoading(false);
    } catch (err) {
      _setIsLoading(false);
      products = [];
      print("Search err $err");
    } finally {
      notifyListeners();
    }
  }

  void deleteProduct(String sku) async {
    try {
      _setIsLoading(true);
      final product = await api.deleteProduct(sku);
      products.removeWhere((element) => element.sku == product.sku);
      _setIsLoading(false);
    } catch (err, stack) {
      _setIsLoading(false);
      print(stack);
    }
  }

  @override
  void notifyListeners() {
    if (!isDispose) {
      super.notifyListeners();
    }
  }

  void _setIsLoading(bool reload) {
    isLoading = reload;
    notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}