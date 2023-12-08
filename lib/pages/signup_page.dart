import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/pages/login_page.dart';
import 'package:ecommerce_task/widgets/on_boarding_page_header.dart';
import 'package:ecommerce_task/pages/validation_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _counter = 0;
  bool isChecked = false; // Initial state of the checkbox

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OnboardingPageHeader(
                title: 'Sign Up',
                description: 'Please enter your information below to sign up'),
            Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: EcommerceButton(
                    title: 'Name', hint: 'Please enter your name')),
            Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: EcommerceButton(
                    title: 'Email', hint: 'Please enter your email')),
            EcommerceButton(
                title: 'Password',
                hint: 'Please enter your password',
                isPasswordField: true),
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 50.0,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ValidationPage()),
                              );
                            },
                            child: Text('Sign Up'),
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    4.0), // Removes rounded edges
                              ),
                            )),
                          )))
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(title: 'title')),
                      );
                    },
                    child: Text('Sign In'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
