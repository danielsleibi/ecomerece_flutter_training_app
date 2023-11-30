import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
        required this.name,
        required this.imageURL,
        this.size = 100});

  final String name;
  final String imageURL;
  final double size;

  TextStyle getNameTextStyle() {
    return TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color:  Colors.white);
  }

  TextStyle getPriceTextStyle() {
    return TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.purple);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size * 2,
        height: size,
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          image: NetworkImage(imageURL), fit: BoxFit.cover)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(padding: EdgeInsets.only(left: 10.0, top: 10.0), child: Text(name, style: getNameTextStyle(),)),
                  ))),
        ]));
  }
}
