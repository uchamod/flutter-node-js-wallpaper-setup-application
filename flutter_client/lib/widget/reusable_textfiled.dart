import 'package:flutter/material.dart';
import 'package:flutter_client/util/constants.dart';

class ReusableTextfiled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isShow;
  final String hint;

  final String? Function(String?)? validchecker;
  final void Function()? addTag;
  final void Function(String)? onSubmit;
  const ReusableTextfiled(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.inputAction,
      required this.isShow,
      required this.hint,
      this.validchecker,
      this.addTag,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      validator: validchecker,
      cursorColor: primaryColor,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      obscureText: isShow,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade400),
        border: formFieldBorder(secondoryColor),
        focusedBorder: formFieldBorder(secondoryColor),
        errorBorder: formFieldBorder(primaryColor),
        enabledBorder: formFieldBorder(secondoryColor),
      ),
    );
  }

  //border style
  OutlineInputBorder formFieldBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: 2,
      ),
    );
  }
}
