import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPressed;
  final bool isLoading; 

  const CustomSocialButton({
    super.key,
    required this.text,
    required this.image,
    required this.onPressed,
    this.isLoading = false, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.grey300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.black,
                  ),
                )
              : Row(
                  key: const ValueKey('buttonContent'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 24);
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}