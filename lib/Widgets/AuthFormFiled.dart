
import 'package:flutter/material.dart';
import '../Utils/AppStyle.dart';

class AuthFormField extends StatelessWidget {
  AuthFormField(
      {super.key,
      this.keyboardType,
      this.hint,
      required this.controller,
      this.validator,
      this.focusNode,
      this.onChange,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.onTap, required void Function(dynamic value) onChanged});
  final TextEditingController controller;
  TextInputType? keyboardType;
  String? hint;
  FocusNode? focusNode;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool obscureText = false;
  final FormFieldValidator<String>? validator;
  Function(String)? onChange;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 2.0,
        left: 2.0,
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChange,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        onTap: onTap,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: TextGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: TextGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: BorderGrey),
          ),
          hintText: hint,
          hintStyle: FormTextStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
