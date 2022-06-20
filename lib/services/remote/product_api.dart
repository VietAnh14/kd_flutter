import 'package:dio/dio.dart';
import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
import 'package:flutter_kd/services/remote/model/add_product_request.dart';
import 'package:flutter_kd/services/remote/model/product.dart';
import 'package:flutter_kd/utils/network_utils.dart';
import 'package:flutter_kd/utils/string_ext.dart';

import '../preferences.dart';

class ProductApi {
  final _dio = Dio();
  final Preferences preferences;
  ProductApi(this.preferences) {
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _dio.options.baseUrl = ApiConst.baseUrl;
  }

  Options getAuthOptions() {
    return Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        ApiConst.authorizationHeader: _requireToken(),
      },
    );
  }

  String _requireToken() {
    final token = preferences.getToken().asBearerToken();
    if (token == null) {
      throw AuthorizationException();
    }
    return token;
  }

  Future<List<Product>> getProductList() async {
    try {
      final response = await _dio.get("api/items", options: getAuthOptions());
      final products = Product.fromJsonList(response.data);
      return products;
    } on DioError catch (e) {
      throw e.toNetworkError(null);
    }
  }

  Future<Product> searchProduct(String sku) async {
    try {
      final data = { "sku": sku };
      final response = await _dio.post("api/item/search", options: getAuthOptions(), data: data);
      return Product.fromJson(response.data);
    } on DioError catch(e) {
      throw e.toNetworkError(null);
    }
  }

  Future<Product> addProduct(AddProductRequest request) async {
    try {
      final response = await _dio.post("api/item/search", options: getAuthOptions(), data: request.toJsonRequest());
      return Product.fromJson(response.data);
    } on DioError catch(e) {
      throw e.toNetworkError(null);
    }
  }
}