import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/services/remote/product_api.dart';
import 'package:flutter_kd/ui/base/base_vm.dart';

class ProductVM extends BaseVM {
  final ProductApi api;
  var products = List<Product>.empty(growable: true);
  bool isLoading = false;
  CancelableOperation? searchOperation;

  ProductVM(this.api) {
    getProductList();
  }

  void getProductList() async {
    safeCall(block: () async {
      _setIsLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      products = await api.getProductList();
      _setIsLoading(false);
    }, onFinally: notifyListeners, onError: onError);
  }

  void onQueryChange(String query) {
    searchOperation?.cancel();
    searchOperation = CancelableOperation.fromFuture(Future.delayed(Duration(seconds: 1)))
        .then((aVoid) => searchProduct(query));
  }

  void searchProduct(String query) {
    safeCall(block: () async {
      _setIsLoading(true);
      final product = await api.searchProduct(query);
      products = [product];
      _setIsLoading(false);
    }, onError: (err, stack) {
      products = [];
      _setIsLoading(false);
    }, onFinally: () {
      notifyListeners();
    });
  }

  void deleteProduct(String sku) async {
    safeCall(
          block: () async {
            _setIsLoading(true);
            final product = await api.deleteProduct(sku);
            products.removeWhere((element) => element.sku == product.sku);
            _setIsLoading(false);
            },
          onError: onError,
          onFinally: () {
            notifyListeners();
          }
        );
  }

  void onError(err, stack) {
    _setIsLoading(false);
    sendError(err, stack);
  }

  void _setIsLoading(bool reload) {
    isLoading = reload;
    notifyListeners();
  }
}