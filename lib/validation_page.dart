import 'package:ecommerce_task/ecommerce_button.dart';
import 'package:ecommerce_task/login_page.dart';
import 'package:ecommerce_task/on_boarding_page_header.dart';
import 'package:ecommerce_task/pin_input.dart';
import 'package:flutter/material.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({super.key});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),

            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OnboardingPageHeader(title: 'Verification', description: 'Please enter the OTP code sent to you by SMS', useLogo: false,),
                Padding(padding: EdgeInsets.only(top: 50.0, bottom: 15.0),child: PinInput()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Didn\'t get a code?'),
                    TextButton(
                        onPressed: () {},
                        child: Text('Send Again'))
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Align(alignment: Alignment.bottomCenter,child: Padding(padding: EdgeInsets.only(bottom: 50.0),child: Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 50.0,
                          child: FilledButton(
                            onPressed: () {},
                            child: Text('Verify'),
                            style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Removes rounded edges
                                  ),
                                )),
                          )))
                ]),))
              ],
            )),


    );
  }
}
