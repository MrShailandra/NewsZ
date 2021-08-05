import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  InputTextWidget(
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
        validator: (value) =>
            value!.isEmpty ? 'This filed cannot be blank' : null,
        obscureText: ot,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
