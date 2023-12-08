import 'package:ecommerce_task/pages/base_loggedin_page.dart';
import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/pages/home_page.dart';
import 'package:ecommerce_task/widgets/on_boarding_page_header.dart';
import 'package:ecommerce_task/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  int _counter = 0;
  bool isChecked = false; // Initial state of the checkbox

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget buildSocialMediaButton(
      String path, double paddingRight, double paddingLeft) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight, left: paddingLeft),
      child: ElevatedButton(
        onPressed: () {
          // Action to perform when the button is pressed
          print('IconButton pressed!');
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15), // Adjust padding as needed
          elevation: 2, // Shadow depth
          shadowColor: Colors.black,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Image.asset(
          path,
          width: 30, // Set width as needed
          height: 30, // Set height as needed
        ), // Icon inside the button
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OnboardingPageHeader(
                    title: 'Welcome back!',
                    description: 'Login to your existing account'),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: EcommerceButton(
                        title: 'Email Address', hint: 'e.g name@example.com')),
                EcommerceButton(title: 'Password', hint: 'e.g **********', isPasswordField: true),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(color: Colors.grey),
                        )
                      ]),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.grey),
                          ))
                    ],
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 50.0,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BaseLoggedInPage()),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: Text('Login'),
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    4.0), // Removes rounded edges
                              ),
                            )),
                          )))
                ]),
                Padding(
                    padding: EdgeInsets.only(top: 25.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSocialMediaButton(
                            'images/google_icon.png', 15.0, 0.0),
                        buildSocialMediaButton(
                            'images/facebook_icon.png', 0.0, 15.0)
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text('Sign Up'))
                  ],
                )
              ],
            )),
          )),
    );
  }
}
