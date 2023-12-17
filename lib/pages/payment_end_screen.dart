import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentEndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
appBar: AppBar(title: Text('Payment'),),
     body:  Center(child: Padding(
       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
       child: Column( mainAxisAlignment: MainAxisAlignment.center,children: [
         Image.asset('images/check.png', width: 75,),
         SizedBox(height: 20.0),
         Text('Payment Successful', style: TextStyle(
           fontSize: 17.0,
           fontWeight: FontWeight.bold,
         ),textAlign: TextAlign.center,),
         SizedBox(height: 10.0,),
         Text('Your order will processed and sent to you as soon as possible', textAlign: TextAlign.center,),
         SizedBox(height: 30.0,),
         Row(
           children: [
             Expanded(
                 child: FilledButton(
                   onPressed: () {
                     Navigator.popUntil(context, (route) => route.isFirst);
                   },
                   child: Text('Continue Shopping'),
                   style: FilledButton.styleFrom(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(
                           5.0), // Set the border radius to zero
                     ),
                   ),
                 )),
           ],
         )
       ],),
     )),
   );
  }



}