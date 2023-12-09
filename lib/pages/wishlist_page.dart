import 'package:ecommerce_task/pages/product_page.dart';
import 'package:ecommerce_task/widgets/category_card.dart';
import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/models/category_model.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/widgets/on_boarding_page_header.dart';
import 'package:ecommerce_task/widgets/product_card.dart';
import 'package:ecommerce_task/pages/signup_page.dart';
import 'package:ecommerce_task/widgets/product_card_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WhishlistPage extends StatefulWidget {
  const WhishlistPage({super.key, required this.productsList});

  final List<ProductModel> productsList;

  @override
  State<WhishlistPage> createState() => _WhishlistPageState();
}

class _WhishlistPageState extends State<WhishlistPage> {

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
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
    return
      SizedBox(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                String name = products[index].name;
                String price = '\$${products[index].priceInDollar}';
                String imageURL = products[index].imageURL;
                bool fav = products[index].fav;
                return Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(productModel: products[index])),
                        );
                        setState(() {});
                      },
                      child: ProductCard2(
                        name: name,
                        price: price,
                        imageURL: imageURL,
                        fav: fav,
                      ),
                    ));
              },
              itemCount: products.length))
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 35.0),
        child: Row(
          children: [
            buildSearchBar(context),
          ],
        ),
      ),
      Expanded(
          child: buildProductSection(context, widget.productsList.where((element) => element.fav == true).toList(), ''))
    ]);
  }
}