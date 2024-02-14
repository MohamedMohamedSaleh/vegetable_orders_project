import 'package:flutter/material.dart';

class CustomFormInput extends StatelessWidget {
  const CustomFormInput({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    this.isFillColor = false,
    this.isTitl = false, this.isPhone = false,
  });
  final String labelText;
  final int maxLines;
  final bool isFillColor;
  final bool isTitl;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: isPhone? TextInputType.number: TextInputType.text,
      decoration: InputDecoration(
        labelStyle: TextStyle(

            fontSize: isFillColor ? 15 : 13, fontWeight: FontWeight.w300),
        labelText: labelText,
        filled: true,
        fillColor: isFillColor ? const Color(0xffFAFFF5) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color:
                isFillColor ? const Color(0xff8AC253) : const Color(0xffDCDCDC),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: isFillColor
                ? const Color(0xff8AC253)
                : !isTitl
                    ? const Color(0xffDCDCDC)
                    : Colors.white,
          ),
        ),
      ),
    );
  }
}
