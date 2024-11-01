import 'package:dio/dio.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/pages/product_page.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/repositories/product_repository.dart';
import 'package:ecommerce_task/widgets/product_card_2.dart';
import 'package:ecommerce_task/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<ProductModel> _productList;
  late bool _isLoadingProducts;
  late TextEditingController _searchController;
  late bool _isFilterOpen;
  late RangeValues _values;
  late double maxValue;
  late double minValue;
  @override
  void initState() {
    super.initState();
    _productList = ProductRepository.instance.getProducts();
    _isLoadingProducts = false;
    _searchController = TextEditingController();
    _isFilterOpen = false;
    _values = RangeValues(0, 1);
    updateMaxMinValues();
    updateRangeValues();
  }

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  void updateRangeValues() {
    double minValue =
        this.minValue > _values.start ? this.minValue : _values.start;
    double maxValue = this.maxValue < _values.end ? this.maxValue : _values.end;

    if (minValue > maxValue) {
      maxValue = this.maxValue;
      minValue = this.minValue;
    }

    _values = RangeValues(minValue, maxValue);
  }

  void updateMaxMinValues() {
    minValue = 0;
    maxValue = 0;
    if (_productList.isNotEmpty) {
      minValue = _productList
          .reduce((value, element) =>
              value.price! < element.price! ? value : element)
          .price!
          .toDouble();
      maxValue = _productList
          .reduce((value, element) =>
              value.price! > element.price! ? value : element)
          .price!
          .toDouble();
    }
  }

  void _handleSearchSearch(text) {
    setState(() {
      _isLoadingProducts = true;
    });

    _requestProductSearch(true);
  }

  Widget buildActionButton(
      IconData icon, double paddingRight, double paddingLeft) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight, left: paddingLeft),
      child: ElevatedButton(
        onPressed: () {
          // Action to perform when the button is pressed
          setState(() {
            _isFilterOpen = !_isFilterOpen;
          });
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15), // Adjust padding as needed
          elevation: 2, // Shadow depth
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        child: Icon(icon), // Icon inside the button
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 10.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes the shadow direction
                ),
              ],
            ),
            child: SizedBox(
                height: 50.0,
                child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearchSearch,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Product',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.purple,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    )))),
      ),
    );
  }

  void _requestProductSearch(bool updateSlider) async {
    ProductRepository repo = ProductRepository.instance;
    String? title;
    RangeValues? priceRange;
    if (_searchController.text.isNotEmpty) {
      title = _searchController.text;
    }
    if (_isFilterOpen && !updateSlider) {
      priceRange = RangeValues(_values.start, _values.end);
    }
    List<ProductModel> searchResults =
        await repo.searchProducts(title, priceRange);

    setState(() {
      _productList = searchResults;
      if (updateSlider) {
        updateMaxMinValues();
        _values = RangeValues(minValue, maxValue);
      } else {
        updateRangeValues();
      }
      _isLoadingProducts = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            buildSearchBar(context),
            buildActionButton(Icons.filter_list_outlined, 0.0, 0.0)
          ],
        ),
      ),
      Visibility(
          visible: _isFilterOpen,
          child: Column(
            children: [
              Text('Price Filter'),
              RangeSlider(
                values: _values,
                divisions: 100,
                min: minValue,
                max: maxValue,
                labels: RangeLabels(
                  _values.start.toInt().toString(),
                  _values.end.toInt().toString(),
                ),
                onChangeEnd: (RangeValues newValues) {
                  _requestProductSearch(false);
                },
                onChanged: (RangeValues newValues) {
                  setState(() {
                    _values = newValues;
                  });
                },
              ),
            ],
          )),
      SizedBox(
        height: 20.0,
      ),
      _isLoadingProducts
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
              child: ProductList(
              products: _productList,
            ))
    ]);
  }
}
