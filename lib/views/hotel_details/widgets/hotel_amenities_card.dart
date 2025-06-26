import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class HotelAmenitiesCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const HotelAmenitiesCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Icon(icon, size: 30, color: AppColors.green)),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
