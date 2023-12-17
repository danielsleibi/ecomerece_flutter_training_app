import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  int _selectedAddress = 0;
  @override
  void initState() {
    super.initState();
  }

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }
  Widget _buildAddress( String number, String description, int index) {
    return GestureDetector(
      onTap: () {setState(() {
        _selectedAddress = index;
      });},
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey),
            border: index == _selectedAddress
                ? Border.all(color: Colors.purple, width: 2.0)
                : null,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.my_location, color: Colors.purple,),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        number,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 0),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 1),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 2),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 3),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 4),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 5),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 6),
              _buildAddress('John Doe, +961-12345678', 'Schools street, behind the official school, Mohasdasd, Lebanon, 1600', 7),



            ],
          ),
        ),
      ),
    );
  }
}
