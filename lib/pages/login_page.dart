import 'package:dio/dio.dart';
import 'package:ecommerce_task/controllers/db/offline/cache_keys.dart';
import 'package:ecommerce_task/controllers/db/offline/shared_helper.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/pages/base_loggedin_page.dart';
import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/widgets/on_boarding_page_header.dart';
import 'package:ecommerce_task/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false; // Initial state of the checkbox
  bool isLoading = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {

    super.dispose();
  }

  void _requestLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response;
      response = await DioHelper.dio.post('auth/login', data: {
        'email': _emailController.text,
        'password': _passwordController.text,
      });

//  Success, login
      if (response.statusCode == 201) {
        await SharedHelper.prefs
            .setString(CacheKeys.isLoggedIn.toString(), true.toString());
        await SharedHelper.prefs.setString(
            CacheKeys.token.toString(), response.data['access_token']);
        Fluttertoast.showToast(
          msg: 'Logged In Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => BaseLoggedInPage(),
          ),
        );
      }

      print(response.data.toString());
    } on DioException catch (error) {
      print(error.toString());
      String message = 'An unexpected error occured!';
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          message = 'Invalid Username or Password!';
        }
      }

      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
//  Error, login
    }
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
                        title: 'Email Address',
                        hint: 'e.g name@example.com',
                        controller: _emailController)),
                EcommerceButton(
                  title: 'Password',
                  hint: 'e.g **********',
                  isPasswordField: true,
                  controller: _passwordController,
                ),
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
                              FocusScope.of(context).unfocus();
                              _requestLogin();
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.grey,
                                  )
                                : Text('Login'),
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
                          Navigator.pushReplacement(
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
