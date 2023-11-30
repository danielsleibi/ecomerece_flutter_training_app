import 'package:ecommerce_task/category_card.dart';
import 'package:ecommerce_task/ecommerce_button.dart';
import 'package:ecommerce_task/models/category_model.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/on_boarding_page_header.dart';
import 'package:ecommerce_task/product_card.dart';
import 'package:ecommerce_task/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<ProductModel> productsList = [
    ProductModel(
        name: 'Bluetooth Printer',
        price: '\$200.75',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    ProductModel(
        name: 'Bluetooth Printer',
        price: '\$200.75',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    ProductModel(
        name: 'Bluetooth Printer',
        price: '\$200.75',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    // ProductModel(
    //     name: 'Bluetooth Printer',
    //     price: '\$200.75',
    //     imageURL:
    //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    // ProductModel(
    //     name: 'Bluetooth Printer',
    //     price: '\$200.75',
    //     imageURL:
    //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    // ProductModel(
    //     name: 'Bluetooth Printer',
    //     price: '\$200.75',
    //     imageURL:
    //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    // ProductModel(
    //     name: 'Bluetooth Printer',
    //     price: '\$200.75',
    //     imageURL:
    //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU')
  ];

  List<CategoryModel> categoryList = [
    CategoryModel(
        name: 'Computers',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    CategoryModel(
        name: 'Phones & Accessories',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU'),
    CategoryModel(
        name: 'Blah blah',
        imageURL:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzzILzJfqwxfKlI7GGeA05fXQ2XlNx0FRZpw&usqp=CAU')
  ];
  Widget buildActionButton(
      IconData icon, double paddingRight, double paddingLeft) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight, left: paddingLeft),
      child: ElevatedButton(
        onPressed: () {
          // Action to perform when the button is pressed
          print('IconButton pressed!');
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15), // Adjust padding as needed
          elevation: 2, // Shadow depth
          shadowColor: Colors.black,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Icon(
          icon
        ), // Icon inside the button
      ),
    );
  }

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  Widget buildProductSection(
      BuildContext context, List<ProductModel> products, String title) {
    return Column(
        children: ([
      Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 18.0, top: 22.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: getTitleTextStyle(), textAlign: TextAlign.left))),
      SizedBox(
          height: 175,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String name = products[index].name;
                String price = products[index].price;
                String imageURL = products[index].imageURL;
                return Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: ProductCard(
                        name: name,
                        price: price,
                        imageURL: imageURL,
                        size: 100));
              },
              itemCount: products.length))
    ]));
  }

  Widget buildCategorySection(
      BuildContext context, List<CategoryModel> categories, String title) {
    return Column(
        children: ([
      Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 18.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: getTitleTextStyle(), textAlign: TextAlign.left))),
      SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String name = categories[index].name;
                String imageURL = categories[index].imageURL;
                return Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: CategoryCard(
                        name: name, imageURL: imageURL, size: 100));
              },
              itemCount: categories.length))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.only(bottom: 35.0),
          child: Row(
            children: [
              buildSearchBar(context),
              buildActionButton(Icons.shopping_cart_outlined, 0.0, 0.0),
              buildActionButton(Icons.notifications_outlined, 0.0, 0.0)
            ],
          ),
        ),
        buildCategorySection(context, categoryList, 'Special for you'),
        buildProductSection(context, productsList, 'Featured Products'),
        buildProductSection(
            context, productsList + productsList, 'Best Selling Products'),
        buildProductSection(context, productsList, 'Best Selling Products'),
        buildProductSection(context, productsList, 'Best Selling Products'),
        buildProductSection(context, productsList + productsList + productsList,
            'Best Selling Products'),
        buildProductSection(context, productsList, 'Best Selling Products'),
      ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all_rounded),
            label: 'Product List',
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
