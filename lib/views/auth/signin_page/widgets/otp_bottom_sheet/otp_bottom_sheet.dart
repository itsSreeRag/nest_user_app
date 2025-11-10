import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/otp_bottom_sheet/otp_header_section.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/otp_bottom_sheet/otp_input_fields.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/otp_bottom_sheet/otp_resend_section.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/otp_bottom_sheet/otp_verify_button.dart';
import 'package:provider/provider.dart';

class OtpBottomSheet extends StatefulWidget {
  final String phoneNumber;
  const OtpBottomSheet({super.key, required this.phoneNumber});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> with SingleTickerProviderStateMixin {
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  String getOtpCode() => otpControllers.map((e) => e.text).join();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAuthProviders>(context);

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(color: AppColors.black.withAlpha((0.1*255).toInt()), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // handle bar
                Container(
                  width: 48,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.grey300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
            
                OtpHeaderSection(phoneNumber: widget.phoneNumber),
                const SizedBox(height: 32),
            
                OtpInputFields(otpControllers: otpControllers, focusNodes: focusNodes),
                const SizedBox(height: 28),
            
                OtpResendSection(provider: provider),
                const SizedBox(height: 24),
            
                OtpVerifyButton(
                  provider: provider,
                  otpCodeGetter: getOtpCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
