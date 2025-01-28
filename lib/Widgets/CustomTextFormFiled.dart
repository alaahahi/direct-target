import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Utils/AppStyle.dart';

GlobalKey<FormState> formstate = GlobalKey();

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hint;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;

  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final Function()? onTap;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;

  CustomTextFormField({
    Key? key,
    this.keyboardType,
    this.hint,
    required this.controller,
    this.validator,
    this.focusNode,
    this.onChange,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.obscureText = false,
    this.onTap,
    this.contentPadding,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 15.0,
        left: 15.0,
      ),
      child: TextFormField(
        enabled: enabled,
        validator: validator,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChange,
        obscureText: obscureText,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        onTap: onTap,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          filled: true,
          fillColor: FormBackGraund.withOpacity(.5),
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
