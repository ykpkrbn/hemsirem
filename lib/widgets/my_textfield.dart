import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixicon;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final String Function(String?)? validator;
  final Key? formKey;
  final bool obscureText;

  const MyTextField({
    Key? key,
    this.textInputType,
    this.hintText,
    this.icon,
    this.suffixicon,
    this.textEditingController,
    this.textInputAction,
    this.validator,
    this.formKey,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        validator: validator,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          suffixIcon: suffixicon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFFe7edeb),
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.blue.shade800,
          ),
        ),
      ),
    );
  }
}
