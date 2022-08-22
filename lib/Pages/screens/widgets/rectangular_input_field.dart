import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'neumorphic_text_field_container.dart';


class RectangularInputField extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const RectangularInputField({Key? key, required this.validator, required this.controller, required this.textInputType,required this.hintText,  required this.icon, required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextFieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        cursorColor: black,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          helperStyle: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 18,
          ),
          prefixIcon: Icon(icon,color: black.withOpacity(0.7),size: 20,),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
