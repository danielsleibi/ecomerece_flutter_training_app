import 'package:ecommerce_task/pages/payment_end_screen.dart';
import 'package:ecommerce_task/pages/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPaymentMethod = 0;

  List<String> paymentMethods = [
    'images/payment_methods/paypal.png',
    'images/payment_methods/visa.png',
    'images/payment_methods/card.png',
    'images/payment_methods/apple-pay.png',
    'images/payment_methods/google-pay.png',
  ];

  TextStyle _getSectionTitleTextStyle() {
    return TextStyle(
        fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black);
  }

  TextStyle _getSectionActionTextStyle() {
    return TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey);
  }

  TextStyle _getSectionInfoTextStyle() {
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey);
  }

  Widget _buildCartSection(List<ProductModel> products) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String name = products[index].name;
          String price = '\$${products[index].priceInDollar}';
          String imageURL = products[index].imageURL;
          bool fav = products[index].fav;
          return Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: products.length - 1 == index ? 10.0 : 0.0),
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
                child: ProductCard(
                  name: name,
                  price: price,
                  imageURL: imageURL,
                  size: 100,
                  fav: fav,
                  noInfo: true,
                ),
              ));
        },
        itemCount: products.length);
  }

  Widget _buildPaymentMethodsSection() {

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(
                  left: 10.0,
                  right: paymentMethods.length - 1 == index ? 10.0 : 0.0),
              child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      _selectedPaymentMethod = index;
                    });
                  },
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        border: Border.all(
                            color: _selectedPaymentMethod == index
                                ? Colors.purple
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.asset(paymentMethods[index]),
                  )));
        },
        itemCount: paymentMethods.length);
  }

  Widget _buildSummarySection(
      BuildContext context, List<ProductModel> products) {
    return Container(
      // height: 250.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product Count'),
                Text(products.length.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub Total'),
                Text('\$' + calculateTotal(0.0).toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Total'), Text('\$' + calculateTotal(20.0).toString())],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Payment Method'), Container(
                width: 50.0,
                height: 25.0,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    border: Border.all(
                        color:Colors.purple
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Image.asset(paymentMethods[_selectedPaymentMethod]),
              )],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<ProductModel> products) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Address',
                  style: _getSectionTitleTextStyle(),
                ),
                Text(
                  'Change Address',
                  style: _getSectionActionTextStyle(),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the shadow direction
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe, +961-12345678',
                            style: _getSectionInfoTextStyle(),
                          ),
                          Text('Schools Street, Behind the Official School',
                              style: _getSectionInfoTextStyle()),
                          Text('Maghdouche, Saida, Lebnanon, 1600',
                              style: _getSectionInfoTextStyle()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping Mode',
                  style: _getSectionTitleTextStyle(),
                ),
                Text(
                  'Change Mode',
                  style: _getSectionActionTextStyle(),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the shadow direction
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: SizedBox(
                        height: 35.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Flat Rate',
                                  style: _getSectionInfoTextStyle(),
                                ),
                                Text(
                                  '\$20',
                                  style: _getSectionInfoTextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Cart',
                  style: _getSectionTitleTextStyle(),
                ),
                Text(
                  'View All',
                  style: _getSectionActionTextStyle(),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(height: 100.0, child: _buildCartSection(products)),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: _getSectionTitleTextStyle(),
                )
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 50.0, child: _buildPaymentMethodsSection()),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: _getSectionTitleTextStyle(),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            _buildSummarySection(context, products),
          ],
        ),
      ),
    );
  }

  double calculateTotal(double shippingExtra) {
    CartModel cart = CartModel.instance;
    double subtotal = cart.getCartItems().fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            ((element.priceInDollar -
                    (element.priceInDollar * element.discount)) *
                cart.getQuantityFor(element)));
    return subtotal + (subtotal == 0.0 ? 0 : shippingExtra);
  }

  @override
  Widget build(BuildContext context) {
    CartModel cart = CartModel.instance;

    return Scaffold(
      appBar: AppBar(title: Text('Check Out')),
      body: Column(children: [
        SizedBox(width: 20.0),
        Text('${cart.getCartItems().length} Products',
            style: TextStyle(color: Colors.grey)),
        SizedBox(
          height: 10.0,
        ),
        Expanded(child: _buildContent(context, cart.getCartItems())),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 40.0, top:16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Coupon',
                    style: _getSectionTitleTextStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        'Add Coupon Code',
                        style: _getSectionInfoTextStyle(),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15.0,),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${calculateTotal(20.0).toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
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

                      CartModel cart = CartModel.instance;
                      cart.clearCart();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               PaymentEndScreen(),
                      ));
                    },
                    child: Text('Pay Now'),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Set the border radius to zero
                      ),
                    ),
                  ))
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
