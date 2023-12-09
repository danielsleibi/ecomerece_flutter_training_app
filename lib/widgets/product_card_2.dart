import 'package:flutter/material.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2(
      {super.key,
      required this.name,
      required this.price,
      required this.imageURL,
      this.size = 100,
      this.fav = false});

  final String name;
  final String price;
  final String imageURL;
  final double size;
  final bool fav;

  TextStyle getNameTextStyle() {
    return TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);
  }

  TextStyle getPriceTextStyle() {
    return TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.purple);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
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
              width: size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                  image: DecorationImage(
                      image: NetworkImage(imageURL), fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'images/heart_icon.png',
                  width: 25, // Set width as needed
                  height: 25, // Set height as needed
                  color: fav ? Colors.red : Colors.grey,
                ),
              )),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 50,
                  child: Text(
                    name,
                    style: getNameTextStyle(),
                    textAlign: TextAlign.left,
                  )),
              SizedBox(
                  height: 25,
                  child: Text(
                    price,
                    style: getPriceTextStyle(),
                    textAlign: TextAlign.left,
                  )),
            ],
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: Icon(Icons.add_shopping_cart, color: Colors.purple,),
          ),
        ]));
  }
}
