import 'package:dio/dio.dart';
import 'package:flutter_kd/services/remote/api_const.dart';
import 'package:flutter_kd/services/remote/api_exception.dart';
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

  String _requireToken() {
    final token = preferences.getToken().asBearerToken();
    if (token == null) {
      throw AuthorizationException();
    }
    return token;
  }

  Future<List<Product>> getProductList() async {
    try {
      final options = Options(headers: {
        ApiConst.authorizationHeader: _requireToken(),
      });
      final response = await _dio.get("api/items", options: options);
      final products = Product.fromJsonList(response.data);
      return products;
    } on DioError catch (e) {
      throw e.toNetworkError(null);
    }
  }
}