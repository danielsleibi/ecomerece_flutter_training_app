import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.price,
      required this.imageURL,
      this.size = 100, this.fav = false});

  final String name;
  final String price;
  final String imageURL;
  final double size;
  final bool fav;

  TextStyle getNameTextStyle() {
    return TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);
  }

  TextStyle getPriceTextStyle() {
    return TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.purple);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size + 75,
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
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
                  ))),
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
                textAlign: TextAlign.right,
              ))
        ]));
  }
}
