import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinInput extends StatefulWidget {
  const PinInput({super.key});

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  FocusNode _firstFocusNode = FocusNode();
  FocusNode _secondFocusNode = FocusNode();
  FocusNode _thirdFocusNode = FocusNode();
  FocusNode _fourthFocusNode = FocusNode();
  TextEditingController _firstTextEditingController = TextEditingController();
  TextEditingController _secondTextEditingController = TextEditingController();
  TextEditingController _thirdTextEditingController = TextEditingController();
  TextEditingController _fourthTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstFocusNode.addListener(() {
      if (_firstFocusNode.hasFocus) {
        _firstTextEditingController.clear();
      }
    });
    _secondFocusNode.addListener(() {
      if (_secondFocusNode.hasFocus) {
        _secondTextEditingController.clear();
      }
    });
    _thirdFocusNode.addListener(() {
      if (_thirdFocusNode.hasFocus) {
        _thirdTextEditingController.clear();
      }
    });
    _fourthFocusNode.addListener(() {
      if (_fourthFocusNode.hasFocus) {
        _fourthTextEditingController.clear();
      }
    });
  }

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    _firstTextEditingController.dispose();
    _secondTextEditingController.dispose();
    _thirdTextEditingController.dispose();
    _fourthTextEditingController.dispose();
    super.dispose();
  }

  Widget buildPinCell(
      BuildContext buildContext,
      TextEditingController controller,
      FocusNode? prevFocus,
      FocusNode currentFocus,
      FocusNode? nextFocus) {
    final double size = 50.0;
    final double spaceing = 20.0;
    return Padding(
        padding: EdgeInsets.only(right: spaceing / 2.0, left: spaceing / 2.0),
        child: SizedBox(
            width: size,
            height: size * 1.5,
            child: Container(
                margin: EdgeInsets.only(top: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset:
                          const Offset(0, 3), // changes the shadow direction
                    ),
                  ],
                ),
                child: SizedBox(
                    width: size,
                    height: size,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller,
                        onChanged: (value) {
                          currentFocus.unfocus();
                          if (value.length == 0) {
                            if (nextFocus != null) {
                              FocusScope.of(context).requestFocus(prevFocus);
                            }
                          } else {
                            if (nextFocus != null) {
                              FocusScope.of(context).requestFocus(nextFocus);
                            }
                          }
                        },
                        maxLength: 1,
                        focusNode: currentFocus,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '_',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ))))));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildPinCell(context, _firstTextEditingController, null,
            _firstFocusNode, _secondFocusNode),
        buildPinCell(context, _secondTextEditingController, _firstFocusNode,
            _secondFocusNode, _thirdFocusNode),
        buildPinCell(context, _thirdTextEditingController, _secondFocusNode,
            _thirdFocusNode, _fourthFocusNode),
        buildPinCell(context, _fourthTextEditingController, _thirdFocusNode,
            _fourthFocusNode, null)
      ],
    );
  }
}
