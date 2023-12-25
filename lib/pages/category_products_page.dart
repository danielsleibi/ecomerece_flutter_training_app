import 'package:dio/dio.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/pages/product_page.dart';
import 'package:ecommerce_task/repositories/product_repository.dart';
import 'package:ecommerce_task/widgets/product_card_2.dart';
import 'package:ecommerce_task/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoryProductPage extends StatefulWidget {
  const CategoryProductPage({super.key, required this.catId});
  final int catId;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  late List<ProductModel> _productList;
  late bool _isLoadingProducts;

  @override
  void initState() {
    super.initState();
    _productList = ProductRepository.instance.getProducts();
    _isLoadingProducts = true;

    _requestProductForCategory(widget.catId);
  }

  void _requestProductForCategory(int categoryId) async {
    ProductRepository repo = ProductRepository.instance;
    List<ProductModel> categoryProducts =
        await repo.productForCategory(categoryId);
    setState(() {
      _productList = categoryProducts;
      _isLoadingProducts = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Products'),
        scrolledUnderElevation: 0.0,
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          // child: Row(
          //   children: [
          //     buildSearchBar(context),
          //     buildActionButton(Icons.filter_list_outlined, 0.0, 0.0)
          //   ],
          // ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Visibility(
            visible: _productList.isEmpty && !_isLoadingProducts,
            child: Text('Sorry, no products exist for the selected category!')),
        _isLoadingProducts
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: ProductList(
                products: _productList,
              ))
      ]),
    );
  }
}
