import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class OtpHeaderSection extends StatelessWidget {
  final String phoneNumber;
  const OtpHeaderSection({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            size: 40,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
         Text(
          'Verify Your Phone',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter the 6-digit code sent to',
          style: TextStyle(fontSize: 15, color: AppColors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          phoneNumber,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
