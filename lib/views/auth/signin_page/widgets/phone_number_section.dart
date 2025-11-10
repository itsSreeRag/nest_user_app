import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:provider/provider.dart';

class PhoneInputSection extends StatelessWidget {
  const PhoneInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAuthProviders>(context);
    final MyAppValidators myAppValidators = MyAppValidators();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Country Code Picker
                CountryCodePicker(
                  onChanged: (country) {
                    provider.updateCountryCode(country.dialCode ?? '+91');
                  },
                  initialSelection: 'IN',
                  favorite: const ['+91', 'IN'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.zero,
                  flagWidth: 24,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(width: 1, height: 40, color: AppColors.grey300),
                // Phone Number Input
                Expanded(
                  child: TextFormField(
                    controller: provider.phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter mobile number',
                      hintStyle: TextStyle(color: AppColors.grey, fontSize: 16),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    validator: myAppValidators.validatePhone,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Continue button with loading state
          MyCustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                provider.sendOTP(context);
              }
            },
            text: 'Continue',
            isLoading: provider.isLoadingPhone,
          ),
        ],
      ),
    );
  }
}