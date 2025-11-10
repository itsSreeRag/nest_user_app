import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/widgets/my_button.dart';

class OtpVerifyButton extends StatelessWidget {
  final MyAuthProviders provider;
  final String Function() otpCodeGetter;

  const OtpVerifyButton({
    super.key,
    required this.provider,
    required this.otpCodeGetter,
  });

  @override
  Widget build(BuildContext context) {
    return provider.isLoading
        ? const SizedBox(
            height: 52,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          )
        : MyCustomButton(
            onPressed: () {
              final otpCode = otpCodeGetter();
              if (otpCode.length == 6) {
                final tempController = TextEditingController(text: otpCode);
                provider.verifyOTP(context, tempController);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please enter all 6 digits'),
                    backgroundColor: AppColors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            text: 'Verify & Continue',
          );
  }
}
