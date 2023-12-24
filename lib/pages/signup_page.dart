import 'package:dio/dio.dart';
import 'package:ecommerce_task/controllers/db/offline/cache_keys.dart';
import 'package:ecommerce_task/controllers/db/offline/shared_helper.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/pages/base_loggedin_page.dart';
import 'package:ecommerce_task/pages/home_page.dart';
import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/pages/login_page.dart';
import 'package:ecommerce_task/widgets/on_boarding_page_header.dart';
import 'package:ecommerce_task/pages/validation_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  bool isChecked = false; // Initial state of the checkbox
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  void _requestSignup() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response;
      response = await DioHelper.dio.post('users', data: {
        'avatar': 'https://api.lorem.space/image/face?w=150&h=220',
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Signed Up Successfully, please login!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(
              title: '',
            ),
          ),
        );
      }

      print(response.data.toString());
    } on DioException catch (error) {
      print(error.toString());
      String message = 'An Unexpected Error Occured!';
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          message = 'Invalid Username or Password!';
        }

        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  if (SharedHelper.prefs.getString(CacheKeys.isLoggedIn.toString()) ==
    //     'true') {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => BaseLoggedInPage(),
    //     ),
    //   );
    // }
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
                  title: 'Name',
                  hint: 'Please enter your name',
                  controller: _nameController,
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: EcommerceButton(
                  title: 'Email',
                  hint: 'Please enter your email',
                  controller: _emailController,
                )),
            EcommerceButton(
              title: 'Password',
              hint: 'Please enter your password',
              isPasswordField: true,
              controller: _passwordController,
            ),
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 50.0,
                          child: FilledButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _requestSignup();
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.grey,
                                  )
                                : Text('Sign Up'),
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
                      Navigator.pushReplacement(
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
