import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundcolor;
  final Color textcolor;
  final double width;
  final double height;
  final String text;

  const MyCustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundcolor,
    required this.textcolor,
    this.width = 200,
    this.height = 50,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textcolor,
          ),
        ),
      ),
    );
  }
}
