import 'package:dio/dio.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductRepository {
  ProductRepository._() {
    _productsList = {};
  }

  // Static instance of the class
  static final ProductRepository _instance = ProductRepository._();

  // Getter to access the instance
  static ProductRepository get instance => _instance;

  late Map<int, ProductModel> _productsList;

  Future<void> fetchProductData() async {
    Response response = await DioHelper.dio.get('products');
    _productsList.clear();
    for (var element in response.data!) {
      ProductModel model = ProductModel.fromJson(element);
      if (model.id != null) {
        _productsList.putIfAbsent(model.id!, () => model);
      }
    }
  }


  Future<List<ProductModel>> searchProducts(
      String? title, RangeValues? price) async {
    if (_productsList.isEmpty) {
      await fetchProductData();
    }

    List<ProductModel> resultProducts = [];
    String params = '';

    if (title != null) {
      params += 'title=$title${price != null ? '&' : ''}';
    }
    if (price != null) {
      params +=
          'price_min=${price.start.toInt()}&price_max=${price.end.toInt()}';
    }
    print(params);
    Response response = await DioHelper.dio.get('products/?$params');

    if (response.data == null) {
      return [];
    }

    for (var element in response.data!) {
      ProductModel searchModel = ProductModel.fromJson(element);
      if (_productsList.containsKey(searchModel.id)) {
        resultProducts.add(_productsList[searchModel.id!]!);
      }
    }

    return resultProducts;
  }

List<ProductModel> getProducts() {
  return _productsList.values.toList();
}

}
