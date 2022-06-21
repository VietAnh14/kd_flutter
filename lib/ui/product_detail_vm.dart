import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kd/services/remote/model/add_product_request.dart';
import 'package:flutter_kd/services/remote/product_api.dart';
import 'package:flutter_kd/ui/product_detail_event.dart';

import '../services/remote/model/product.dart';

class ProductDetailVM extends ChangeNotifier {
  ProductApi _api;
  late Product product;
  bool isLoading = false;
  bool isValid = false;
  late bool isEditing = false;
  final _eventStream = StreamController<ProductDetailEvent>.broadcast();
  Stream<ProductDetailEvent> get event => _eventStream.stream;
  final _errorStream = StreamController<dynamic>.broadcast();
  Stream<dynamic> get error => _errorStream.stream;

  ProductDetailVM(this._api, Product? product) {
    this.product = product ?? Product.empty();
    this.isEditing = product != null;
  }

  @override
  void dispose() {
    _eventStream.close();
    _errorStream.close();
    super.dispose();
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


  void addProduct() async {
    try {
      _setLoading(true);
      final request = AddProductRequest.fromProduct(product);
      await _api.addProduct(request);
      _sendEvent(AddProductSuccessEvent());
      _setLoading(false);
    } catch (e, stack) {
      print(stack);
      _setLoading(false);
      _errorStream.add(e);
    }
  }

  void _sendEvent(ProductDetailEvent event) {
    _eventStream.add(event);
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}