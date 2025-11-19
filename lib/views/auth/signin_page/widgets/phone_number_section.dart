import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:provider/provider.dart';

class PhoneInputSection extends StatefulWidget {
  const PhoneInputSection({super.key});

  @override
  State<PhoneInputSection> createState() => _PhoneInputSectionState();
}

class _PhoneInputSectionState extends State<PhoneInputSection> {
  final formKey = GlobalKey<FormState>();
  final MyAppValidators myAppValidators = MyAppValidators();
  String selectedCountryCode = '+91';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAuthProviders>(context, listen: false);

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            cursorColor: AppColors.black54,
            controller: provider.phoneNumberController,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black87,
            ),
            decoration: InputDecoration(
              hintText: 'Enter mobile number',
              hintStyle: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Country Code Picker as prefix
                  CountryCodePicker(
                    onChanged: (country) {
                      setState(() {
                        selectedCountryCode = country.dialCode ?? '+91';
                      });
                      provider.updateCountryCode(selectedCountryCode);
                    },
                    initialSelection: 'IN',
                    favorite: const ['+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    padding: EdgeInsets.only(left: 12),
                    flagWidth: 24,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black87,
                    ),
                  ),
                  // Vertical divider
                  Container(
                    width: 1,
                    height: 40,
                    color: AppColors.grey300,
                    margin: EdgeInsets.only(right: 12),
                  ),
                ],
              ),
              // Border styling
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.grey300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.green, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            validator: myAppValidators.validatePhone,
          ),
          SizedBox(height: 20),
          // Continue button with loading state
          MyCustomButton(
            backgroundcolor: AppColors.secondary,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                provider.sendOTP(context);
              }
            },
            text: 'Continue',
          ),
        ],
      ),
    );
  }
}
