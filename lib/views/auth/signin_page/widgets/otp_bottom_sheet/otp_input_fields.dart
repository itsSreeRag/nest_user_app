import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nest_user_app/constants/colors.dart';

class OtpInputFields extends StatefulWidget {
  final List<TextEditingController> otpControllers;
  final List<FocusNode> focusNodes;

  const OtpInputFields({
    super.key,
    required this.otpControllers,
    required this.focusNodes,
  });

  @override
  State<OtpInputFields> createState() => _OtpInputFieldsState();
}

class _OtpInputFieldsState extends State<OtpInputFields> {
  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      widget.focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          height: 56,
          child: TextFormField(
            controller: widget.otpControllers[index],
            focusNode: widget.focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor:
                  widget.otpControllers[index].text.isNotEmpty
                      ? AppColors.primary.withAlpha((0.05 * 255).toInt())
                      : AppColors.grey.withAlpha((0.05 * 255).toInt()),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.grey300, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2.5,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {});
              onOtpChanged(value, index);
            },
          ),
        );
      }),
    );
  }
}
