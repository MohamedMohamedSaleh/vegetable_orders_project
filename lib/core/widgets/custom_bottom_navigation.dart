import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.text,
    required this.buttonText, this.paddingBottom = 26,
  });
  final String text;
  final String buttonText;
  final double paddingBottom;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextButton(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}