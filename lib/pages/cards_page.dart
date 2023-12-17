import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  int _selectedCard = 0;
  @override
  void initState() {
    super.initState();
  }

  TextStyle getTitleTextStyle() {
    return TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
  }

  Widget _buildCard(
      String number, String expDate, String typeImage, Color? typeColor,  int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _selectedCard = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: index == _selectedCard
                ? Border.all(color: Colors.purple, width: 3.0)
                : null,
            color: index == _selectedCard
                ? Color.fromRGBO(30, 30, 30, 1.0)
                : Colors.grey.withOpacity(0.5)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bank Name',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(number, style: TextStyle(color: Colors.white, fontSize: 22.0)),
              Row(
                children: [
                  SizedBox(
                    width: 160.0,
                  ),
                  Text(expDate, style: TextStyle(color: Colors.white))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CARD HOLDER', style: TextStyle(color: Colors.white)),
                  Image.asset(
                    typeImage,
                    width: 100.0,
                    height: 50.0,
                    color: typeColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cards'),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCard('1245 1645 5481 3425', '01/21',
                  'images/payment_methods/visa.png',Colors.white, 0),
              SizedBox(height: 20.0,),
              _buildCard('1245 1645 5481 3425', '01/21',
                  'images/payment_methods/card.png', null, 1)
            ],
          ),
        ),
      ),
    );
  }
}
