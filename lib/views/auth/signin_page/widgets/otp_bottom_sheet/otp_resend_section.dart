import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';

class OtpResendSection extends StatelessWidget {
  final MyAuthProviders provider;
  const OtpResendSection({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text("Didn't receive the code? ", style: TextStyle(color: AppColors.grey, fontSize: 14)),
        TextButton(
          onPressed: provider.isLoading ? null : () => provider.sendOTP(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Resend',
            style: TextStyle(
              color: provider.isLoading ? AppColors.grey : AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
