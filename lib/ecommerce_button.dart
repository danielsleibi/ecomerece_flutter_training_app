import 'package:flutter/material.dart';

class EcommerceButton extends StatefulWidget {
  const EcommerceButton({super.key, required this.title, required this.hint, this.isPasswordField=false});
  final String title;
  final String hint;
  final bool isPasswordField;

  @override
  State<EcommerceButton> createState() => _EcommerceButtonState();
}

class _EcommerceButtonState extends State<EcommerceButton> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.grey))),
      Container(
          margin: EdgeInsets.only(top: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes the shadow direction
              ),
            ],
          ),
          child: SizedBox(
              height: 50.0,
              child: TextField(
                obscureText: widget.isPasswordField,
                  decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ))))
    ]);
  }
}
