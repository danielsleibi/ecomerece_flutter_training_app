import 'package:ecommerce_task/pages/categories_page.dart';
import 'package:ecommerce_task/pages/search_page.dart';
import 'package:ecommerce_task/widgets/category_card.dart';
import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/pages/home_page.dart';
import 'package:ecommerce_task/models/category_model.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/widgets/on_boarding_page_header.dart';
import 'package:ecommerce_task/widgets/product_card.dart';
import 'package:ecommerce_task/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BaseLoggedInPage extends StatefulWidget {
  const BaseLoggedInPage({super.key});

  @override
  State<BaseLoggedInPage> createState() => _BaseLoggedInPageState();
}

class _BaseLoggedInPageState extends State<BaseLoggedInPage> {

  List<ProductModel> productsList = [
    ProductModel(
        name: 'IPhone 15 Pro Max',
        priceInDollar: 1200.0,
        imageURL:
        'https://media.istockphoto.com/id/1426145822/photo/iphone-14-pro-home-screen-with-app-icons.jpg?s=612x612&w=0&k=20&c=oJOjfGgBYg8m1G3VjZL70b8M8I2bSGPC8kdgbosWLws=',
        description:
        'Aluminum design \nCeramic Shield front \nColor-infused glass back',
        discount: 0.32),
    ProductModel(
        name: 'MacBook Pro',
        priceInDollar: 1999.99,
        imageURL:
        'https://media.istockphoto.com/id/1816802404/photo/apple-macbook-pro-15-inch-laptop.jpg?s=612x612&w=0&k=20&c=7QlgjZyh5u8Krm7j6yC9Kak8DbmeiWwJRguWrKIC0cU='),
    ProductModel(
        name: 'Bluetooth Printer',
        priceInDollar: 200.75,
        imageURL:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
  ];


  int _selectedIndex = 0;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomePage(productsList: productsList),
      CategoriesPage(),
      SearchPage(productsList: productsList)

    ];

  }

  final List<String> _childrenTitles = [
    '',
    'Categories',
    'Search',

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_childrenTitles.length > _selectedIndex ? _childrenTitles[_selectedIndex] : _childrenTitles[0], style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: _children.length > _selectedIndex ? _children[_selectedIndex] : _children[0],
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
