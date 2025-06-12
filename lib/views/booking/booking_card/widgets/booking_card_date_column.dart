import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class DateColumn extends StatelessWidget {
  final String label;
  final String date;

  const DateColumn({super.key, 
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.grey600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style:  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.black87,
          ),
        ),
      ],
    );
  }
}