import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class MyCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundcolor;
  final Color textcolor;
  final double width;
  final double height;
  final String text;
  final bool isLoading; 

  const MyCustomButton({
    super.key,
    required this.onPressed,
    this.backgroundcolor = AppColors.primary,
    this.textcolor = AppColors.white,
    this.width = 200,
    this.height = 50,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // disable when loading
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: textcolor,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  text,
                  key: const ValueKey('buttonText'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textcolor,
                  ),
                ),
        ),
      ),
    );
  }
}
