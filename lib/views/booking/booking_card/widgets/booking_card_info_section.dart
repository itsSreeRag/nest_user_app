import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class GuestInfoSection extends StatelessWidget {
  final String adults;
  final String children;

  const GuestInfoSection({
    super.key,
    required this.adults,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _GuestInfo(
          icon: Icons.person,
          text: '$adults Adults',
        ),
        const SizedBox(width: 24),
        _GuestInfo(
          icon: Icons.child_care,
          text: '$children Children',
        ),
      ],
    );
  }
}

class _GuestInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _GuestInfo({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}