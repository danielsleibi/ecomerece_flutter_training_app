import 'package:ecommerce_task/pages/cards_page.dart';
import 'package:ecommerce_task/pages/product_page.dart';
import 'package:ecommerce_task/pages/shipping_address_page.dart';
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  Widget buildItem(String title, IconData iconData) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 3, // Blur radius
            offset: Offset(0, 3), // Offset
          ),
        ],
      ),
      child: Row(children: [
        SizedBox(
          width: 10.0,
        ),
        Icon(iconData),
        SizedBox(
          width: 15.0,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
        Expanded(child: SizedBox()),
        Icon(
          Icons.arrow_forward_ios,
          size: 20.0,
        ),
        SizedBox(
          width: 10.0,
        )
      ]),
    );
  }

  Widget buildItems(BuildContext context) {
    return SizedBox(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                child: Column(
                  children: [
                    buildItem('My Account', Icons.account_circle_outlined),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildItem('My Orders', Icons.shopping_bag_outlined),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildItem('Language Settings', Icons.language_outlined),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(onTap:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShippingAddressPage(),
                          ));
                    }, child: buildItem('Shipping Address', Icons.my_location_outlined)),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CardsPage(),
                          ));
                    }, child: buildItem('My Cards', Icons.credit_card_outlined)),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildItem('Settings', Icons.settings_outlined),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildItem('Privacy Policy', Icons.policy_outlined),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildItem('FAQ', Icons.info_outline),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        Icons.account_circle_rounded,
        size: 120,
      ),
      Text('Daniel Sleibi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      SizedBox(height: 70.0,),
      Expanded(child: buildItems(context))
    ]);
  }
}
