import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class PaymentIcon extends StatelessWidget {
  const PaymentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Icon(Icons.payment, size: 40, color: AppColors.blue600),
    );
  }
}
