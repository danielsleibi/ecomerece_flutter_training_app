import 'package:ecommerce_task/models/cart_model.dart';
import 'package:ecommerce_task/pages/checkout_page.dart';
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

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  Widget buildProductSection(
      BuildContext context, List<ProductModel> products, String title) {
    return SizedBox(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
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
                        productModel: products[index],
                        cart_mode: true,
                        size: 100.0,
                        callback: () {
                          setState(() {});
                        }),
                  ));
            },
            itemCount: products.length));
  }

  double calculateTotal(double shippingExtra) {
    CartModel cart = CartModel.instance;
    double subtotal = cart.getCartItems().fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            ((element.price! -
                    (element.price! * element.discount)) *
                cart.getQuantityFor(element)));
    return subtotal + (subtotal == 0.0 ? 0 : shippingExtra);
  }

  @override
  Widget build(BuildContext context) {
    CartModel cart = CartModel.instance;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(children: [
        SizedBox(width: 20.0),
        Text('${cart.getCartItems().length} Products',
            style: TextStyle(color: Colors.grey)),
        SizedBox(
          height: 10.0,
        ),
        Expanded(child: buildProductSection(context, cart.getCartItems(), '')),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 40.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '\$${calculateTotal(0.0).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '\$${calculateTotal(20.0).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                  child: FilledButton(
                onPressed: () {
                  if(cart.getCartItems().length == 0){
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutPage()),
                  );
                },
                child: Text('Check Out'),
                style: FilledButton.styleFrom(
                  backgroundColor: cart.getCartItems().length > 0 ? Colors.purple : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        5.0), // Set the border radius to zero
                  ),
                ),
              ))
            ],
          ),
        )
      ]),
    );
  }
}
