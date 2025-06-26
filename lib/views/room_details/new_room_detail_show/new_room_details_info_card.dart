import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class RoomDetaiInfolItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final Color valueColors;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;

  const RoomDetaiInfolItem({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.valueColors = AppColors.black,
    this.icon,
    this.iconColor = AppColors.primary,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, size: iconSize, color: iconColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColors.grey600),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 10),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: valueColors,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 4),
              Text(
                unit!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.grey600),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
