import 'package:flutter/material.dart';

class OnboardingPageHeader extends StatelessWidget {
  const OnboardingPageHeader(
      {super.key,
      required this.title,
      required this.description,
      this.useLogo = true});

  final String title;
  final String description;
  final bool useLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            )),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              textAlign: TextAlign.left,
            )),
        Visibility(
            visible: useLogo,
            child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0, top: 30.0),
                child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Image(
                      image: AssetImage('images/shop.png'),
                      fit: BoxFit.fill,
                    ))))
      ],
    );
  }
}
