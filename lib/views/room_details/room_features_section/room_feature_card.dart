import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String feature;
  final bool isAvailable;
  final IconData? customIcon;
  final Color? activeColor;
  final Color? inactiveColor;

  const FeatureCard({
    super.key,
    required this.feature,
    required this.isAvailable,
    this.customIcon,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color active = activeColor ?? Colors.green;
    final Color inactive = inactiveColor ?? Colors.red;

    final Color backgroundColor =
        isAvailable ? active.withAlpha(25) : inactive.withAlpha(25);

    final Color borderColor =
        isAvailable ? active.withAlpha(77) : inactive.withAlpha(77);

    final Color iconColor = isAvailable ? active : inactive;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              customIcon ?? (isAvailable ? Icons.check_circle : Icons.cancel),
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isAvailable ? Colors.black87 : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}