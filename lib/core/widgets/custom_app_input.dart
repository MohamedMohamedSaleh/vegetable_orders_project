import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/core/widgets/app_image.dart';

class CustomAppInput extends StatefulWidget {
  const CustomAppInput({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.paddingBottom = 16,
    this.isPhone = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.validator,
    this.controller,
    this.fillColor = Colors.white
  });
  final Color fillColor;
  final String labelText;
  final String prefixIcon;
  final double paddingBottom;
  final bool isPhone;
  final bool isPassword;
  final bool isEnabled;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;

  @override
  State<CustomAppInput> createState() => _CustomAppInputState();
}

class _CustomAppInputState extends State<CustomAppInput> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.paddingBottom,
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        enabled: widget.isEnabled,
        keyboardType:
            widget.isPhone ? TextInputType.number : TextInputType.text,
        obscureText: isSecure && widget.isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          labelStyle: !widget.isEnabled && widget.labelText != 'المدينة'
              ? TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400)
              : null,
          labelText: widget.labelText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: AppImage(
                widget.prefixIcon,
                width: 18,
                height: 20,
              ),
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    isSecure = !isSecure;
                    setState(() {});
                  },
                  icon:
                      Icon(isSecure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          icon: widget.isPhone
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffF3F3F3),
                    ),
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    // color: Colors.red,
                  ),
                  width: 60,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Image.asset("assets/images/saudia_flag.png"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "+966",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
