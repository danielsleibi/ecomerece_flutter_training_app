import 'package:dio/dio.dart';
import 'package:ecommerce_task/controllers/db/offline/cache_keys.dart';
import 'package:ecommerce_task/controllers/db/offline/shared_helper.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/models/category_model.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/pages/categories_page.dart';
import 'package:ecommerce_task/pages/home_page.dart';
import 'package:ecommerce_task/pages/login_page.dart';
import 'package:ecommerce_task/pages/profile_page.dart';
import 'package:ecommerce_task/pages/search_page.dart';
import 'package:ecommerce_task/pages/wishlist_page.dart';
import 'package:ecommerce_task/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class BaseLoggedInPage extends StatefulWidget {
  const BaseLoggedInPage({super.key});

  @override
  State<BaseLoggedInPage> createState() => _BaseLoggedInPageState();
}

class _BaseLoggedInPageState extends State<BaseLoggedInPage> {
  late List<CategoryModel> categoryList;

  int _selectedIndex = 0;
  late List<Widget> _children;
  bool isLoadingCategories = false;
  bool isLoadingProducts = false;

  @override
  void initState() {
    super.initState();
    categoryList = [];

    _children = [
      HomePage(categoryList: categoryList),
      CategoriesPage(categoryList: categoryList),
      SearchPage(),
      WhishlistPage(),
      ProfilePage()
    ];

    setState(() {
      isLoadingCategories = true;
      isLoadingProducts = true;
    });
    _requestCategoryAPI();
    _requestProductsAPI();
  }

  void _requestCategoryAPI() async {
    Response response = await DioHelper.dio.get('categories');

    for (var element in response.data!) {
      categoryList.add(CategoryModel.fromJson(element));
    }

    setState(() {
      isLoadingCategories = false;
    });
  }

  void _requestProductsAPI() async {
    await ProductRepository.instance.fetchProductData();

    setState(() {
      isLoadingProducts = false;
    });
  }

  final List<String> _childrenTitles = [
    '',
    'Categories',
    'Search',
    'Whish List',
    '',
  ];

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SharedHelper.prefs.getString(CacheKeys.isLoggedIn.toString()) !=
        'true') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(title: ''),
        ),
      );
    }

    bool isLoading = isLoadingCategories || isLoadingProducts;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          _childrenTitles.length > _selectedIndex
              ? _childrenTitles[_selectedIndex]
              : _childrenTitles[0],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _children.length > _selectedIndex
                  ? _children[_selectedIndex]
                  : _children[0]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

//
// ProductCard(
// name: 'Bluetooth Printer',
// price: '\$200.75',
// imageURL:
// 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU',
// size: 100)
