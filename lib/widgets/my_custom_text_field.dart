import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/password_field_types.dart';
import 'package:nest_user_app/controllers/custometextfield_provider/custometexfield_provider.dart';
import 'package:provider/provider.dart';

class MyCustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final PasswordFieldType? passwordType;
  final String? prefixText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final AutovalidateMode autovalidateMode;
  final int? maxlength;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;

  const MyCustomTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    required this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.obscureText = false,
    this.passwordType,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    required this.validator,
    this.onChanged,
    this.contentPadding,
    this.borderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.maxlength,
    this.readOnly = false,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustometexfieldProvider>(
      builder: (context, provider, child) {
        final isPasswordField = obscureText && passwordType != null;
        final isObscure =
            isPasswordField ? provider.isObscure(passwordType!) : false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null && labelText!.isNotEmpty)
              Text(
                labelText!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black54,
                ),
              ),
            if (labelText != null && labelText!.isNotEmpty) SizedBox(height: 8),
            TextFormField(
              minLines: minLines,
              maxLines: maxLines,
              controller: controller,
              obscureText: isPasswordField ? isObscure : false,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              validator: validator,
              onChanged: onChanged,
              maxLength: maxlength,
              autovalidateMode: autovalidateMode,
              readOnly: readOnly,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixText: prefixText,
                hintText: hintText,
                hintStyle: TextStyle(color: AppColors.black38, fontSize: 14),
                prefixIcon:
                    prefixIcon != null
                        ? Icon(prefixIcon, color: AppColors.primary, size: 20)
                        : null,
                suffixIcon:
                    isPasswordField
                        ? IconButton(
                          onPressed: () {
                            provider.toggleVisibility(passwordType!);
                          },
                          icon: Icon(
                            isObscure ? Icons.visibility : Icons.visibility_off,
                          ),
                        )
                        : null,
                contentPadding:
                    contentPadding ??
                    const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 18.0,
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: borderColor ?? AppColors.grey300,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: focusedBorderColor ?? AppColors.primary,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: enabledBorderColor ?? AppColors.grey300,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: errorBorderColor ?? AppColors.red,
                    width: 1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
