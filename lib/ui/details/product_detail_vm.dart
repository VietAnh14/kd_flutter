import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/add_product_request.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/services/remote/product_api.dart';
import 'package:flutter_kd/ui/base/base_vm.dart';
import 'package:flutter_kd/ui/details/product_detail_event.dart';

class ProductDetailVM extends BaseVM {
  ProductApi _api;
  late Product product;
  bool isLoading = false;
  bool isValid = false;
  late bool isAdding = true;

  ProductDetailVM(this._api, Product? product) {
    this.product = product ?? Product.empty();
    this.isAdding = product == null;
  }

  void _validateProduct() {
    if (product.productName.isEmpty || product.sku.isEmpty || product.unit.isEmpty) {
      isValid = false;
    } else if (product.quantity < 0 || product.price < 0 || product.status < 0) {
      isValid = false;
    } else {
      isValid = true;
    }
    notifyListeners();
  }

  void skuChange(String sku) {
    product.sku = sku;
    _validateProduct();
  }

  void nameChange(String name) {
    product.productName = name;
    _validateProduct();
  }

  void priceChange(String price) {
    try {
      product.price = int.parse(price);
    } catch (_) {
      product.price = -1;
    } finally {
      _validateProduct();
    }
  }

  void unitChange(String unit) {
    product.unit = unit;
    _validateProduct();
  }

  void statusChange(String status) {
    try {
      product.status = int.parse(status);
    } catch (_) {
      product.status = - 1;
    } finally {
      _validateProduct();
    }
  }

  void qtyChange(String qty) {
    try {
      product.quantity= int.parse(qty);
    } catch (_) {
      product.quantity = -1;
    } finally {
      _validateProduct();
    }
  }

  void onActionClick() {
    if (isAdding) {
      addProduct();
    } else {
      updateProduct();
    }
  }

  void updateProduct() {
    safeCall(block: () async {
      _setLoading(true);
      final request = AddProductRequest.fromProduct(product);
      final response = await _api.updateProduct(request);
      sendEvent(ProductDetailEvent.updateProductSuccess());
      _setLoading(false);
    }, onError: sendError);
  }

  void addProduct() {
    safeCall(block: () async {
      _setLoading(true);
      final request = AddProductRequest.fromProduct(product);
      final response = await _api.addProduct(request);
      sendEvent(ProductDetailEvent.addProductSuccess());
      _setLoading(false);
    }, onError: sendError);
  }

  @override
  void sendError(error, stack) {
    _setLoading(false);
    super.sendError(error, stack);
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}