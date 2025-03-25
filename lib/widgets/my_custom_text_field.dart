import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/custometextfield_provider/custometexfield_provider.dart';
import 'package:provider/provider.dart';

class MyCustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final Icon? prefixIcon;
  // final Icon? suffixIcon;
  final bool obscureText;
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

  const MyCustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixText,
    this.prefixIcon,
    // this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.borderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.maxlength,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustometexfieldProvider>(
      builder: (context, custometexfieldProvider, child) {
        return TextFormField(
          controller: controller,
          obscureText:
              obscureText ? custometexfieldProvider.isObscureText : obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onChanged: onChanged,
          maxLength: maxlength,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            prefixText: prefixText,
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon:
                obscureText
                    ? IconButton(
                      onPressed: () {
                        custometexfieldProvider.visibilityButtonClick();
                      },
                      icon:
                          custometexfieldProvider.isObscureText
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                    )
                    : null,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: focusedBorderColor ?? Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: enabledBorderColor ?? Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: errorBorderColor ?? Colors.red),
            ),
          ),
        );
      },
    );
  }
}
