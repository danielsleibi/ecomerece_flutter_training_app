import 'package:ecommerce_task/models/cart_model.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductCard2 extends StatefulWidget {
  const ProductCard2(
      {super.key,
      required this.productModel,
      this.size = 100,
      this.cart_mode = false, this.callback = _defaultCallback});

  final ProductModel productModel;
  final double size;
  final bool cart_mode;
  final Function() callback;

  // Default callback function
  static void _defaultCallback() {
    print('Default callback');
  }

  @override
  State<ProductCard2> createState() => _ProductCard2State();
}

class _ProductCard2State extends State<ProductCard2> {
  TextStyle getNameTextStyle() {
    return TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);
  }

  TextStyle getPriceTextStyle() {
    return TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.purple);
  }

  @override
  Widget build(BuildContext context) {
    CartModel cart = CartModel.instance;
    return Container(
        width: widget.size,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // Offset
            ),
          ],
        ),
        child: Row(children: [
          Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0)),
                  image: DecorationImage(
                      image: NetworkImage(widget.productModel.imageURL),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'images/heart_icon.png',
                  width: 25, // Set width as needed
                  height: 25, // Set height as needed
                  color: widget.productModel.fav ? Colors.red : Colors.grey,
                ),
              )),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 50,
                  child: Text(
                    widget.productModel.name,
                    style: getNameTextStyle(),
                    textAlign: TextAlign.left,
                  )),
              SizedBox(
                  height: 25,
                  child: Text(
                    '\$${widget.productModel.priceInDollar}',
                    style: getPriceTextStyle(),
                    textAlign: TextAlign.left,
                  )),
              Visibility(

                visible:widget.productModel.discount != 0.0 ,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red)),
                  child: SizedBox(child: Text(
                    '-${(widget.productModel.discount * 100).toInt()}% Off',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 8.0,
                        fontWeight: FontWeight.w500),
                  ),),
                ),
              )
            ],
          ),
          Expanded(child: SizedBox()),
          Visibility(
            visible: !widget.cart_mode,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  if (cart.isInCart(widget.productModel)) {
                    setState(() {
                      cart.removeFromCart(widget.productModel);
                    });

                    return;
                  }
                  setState(() {
                    cart.addToCart(widget.productModel);
                  });
                },
                child: Icon(
                  cart.isInCart(widget.productModel)
                      ? Icons.remove_shopping_cart_outlined
                      : Icons.add_shopping_cart,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.cart_mode,
            child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          cart.addOneMoreFor(widget.productModel);
                          widget.callback();
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                    Text('${cart.getQuantityFor(widget.productModel)}'),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          cart.removeOneLessFor(widget.productModel);
                          widget.callback();
                        });
                      },
                      child: Icon(Icons.remove),
                    )
                  ],
                )),
          ),
        ]));
  }
}
