import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputMobileWidget extends StatelessWidget {
  InputMobileWidget(
      {required this.controller, required this.hintText, required this.ot});
  final TextEditingController controller;
  final String hintText;
  final bool ot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: TextFormField(
        validator: (value) {
          if (value!.length != 10) {
            return 'Mobile Number must be of 10 digit';
          }
          return null;
        },
        obscureText: ot,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
