import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class RoomDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final Color valueColors;

  const RoomDetailItem({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.valueColors = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.grey600),
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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