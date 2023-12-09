import 'package:ecommerce_task/pages/categories_page.dart';
import 'package:ecommerce_task/pages/profile_page.dart';
import 'package:ecommerce_task/pages/search_page.dart';
import 'package:ecommerce_task/pages/wishlist_page.dart';
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
            'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFjYm9vayUyMHByb3xlbnwwfHwwfHx8MA%3D%3D'),
    ProductModel(
        name: 'Samsung Galaxy S23 Ultra',
        priceInDollar: 1000.0,
        imageURL:
            'https://darazmobile.com/wp-content/uploads/2022/10/Samsung-Galaxy-S23-Ultra.jpg',
    description: 'The Samsung Galaxy S23 specs are top-notch including a Snapdragon 8 Gen 2 chipset, 8GB RAM coupled with 128/256GB storage, and a 3900mAh battery.')
,ProductModel(name: 'Nike Shoes', priceInDollar: 200.0, imageURL: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', discount: 0.05),
  ProductModel(name: 'Dove Body Care', priceInDollar: 10.0, imageURL: 'https://images.unsplash.com/photo-1625772452859-1c03d5bf1137?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHByb2R1Y3RzfGVufDB8fDB8fHww', description: 'Dove Body care Product, rich nourishment'),
  ProductModel(name: 'Coco Chanel', priceInDollar: 150.0, imageURL: 'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fHByb2R1Y3RzfGVufDB8fDB8fHww', description: 'Satisfy your senses'),
ProductModel(name: 'Yummy Burger', priceInDollar: 15.0, imageURL: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjN8fHByb2R1Y3RzfGVufDB8fDB8fHww', description: 'I got hungry developing this')
  ];

  List<CategoryModel> categoryList = [
    CategoryModel(
        name: 'Computers',
        imageURL:
            'https://media.istockphoto.com/id/1249219777/photo/shopping-online-concept-parcel-or-paper-cartons-with-a-shopping-cart-logo-in-a-trolley-on-a.jpg?s=612x612&w=0&k=20&c=EWKEahyVLY8iAHyirCCDESHRGW37lqUJ7In0SssNSLE='),
    CategoryModel(
        name: 'Phones & Accessories',
        imageURL:
            'https://media.istockphoto.com/id/1336136316/photo/woman-online-shopping-on-smart-phone-fashion-clothes-at-home.jpg?s=612x612&w=0&k=20&c=PYDR6zm5uC84qF-6a1dI8G5uXWrTg0wWMcjHSewsAM8='),
    CategoryModel(
        name: 'Blah blah',
        imageURL:
            'https://media.istockphoto.com/id/1311600080/photo/small-shipping-packages-on-a-notebook-with-the-inscription-online-shopping.jpg?s=612x612&w=0&k=20&c=vDPqIQsqzCvEaEZF2R5IeGz_8Gv-YRI_HzbKux8TaqM='),
    CategoryModel(
        name: 'Beauty',
        imageURL:
            'https://t4.ftcdn.net/jpg/02/73/55/33/360_F_273553300_sBBxIPpLSn5iC5vC8FwzFh6BJDKvUeaC.jpg'),
  ];

  int _selectedIndex = 0;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomePage(productsList: productsList, categoryList: categoryList),
      CategoriesPage(categoryList: categoryList),
      SearchPage(productsList: productsList),
      WhishlistPage(productsList: productsList),
      ProfilePage()
    ];
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _childrenTitles.length > _selectedIndex
              ? _childrenTitles[_selectedIndex]
              : _childrenTitles[0],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: _children.length > _selectedIndex
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
