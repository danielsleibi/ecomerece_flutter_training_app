import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/pages/product_page.dart';
import 'package:ecommerce_task/widgets/product_card_2.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.products});

  final List<ProductModel> products;
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                productModel: widget.products[index])),
                      );
                      setState(() {});
                    },
                    child: ProductCard2(
                      productModel: widget.products[index],
                      size: 100.0,
                    ),
                  ));
            },
            itemCount: widget.products.length));
  }
}
