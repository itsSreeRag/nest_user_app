import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/login_page_email/login_page_email.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/custom_login_button.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/nestgo_header.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/or_divider.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/phone_number_section.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/sign_in_page_text.dart';
import 'package:provider/provider.dart';

// Main Login Page
class SignInPageMain extends StatelessWidget {
  const SignInPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAuthProviders>(context);

    return Scaffold(
      body: Consumer<MyAuthProviders>(
        builder: (context, value, _) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withAlpha(200),
                      AppColors.primary,
                      AppColors.primary.withAlpha(200),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          NsetGoHeader(),
                          SizedBox(height: 120),

                          Column(
                            children: [
                              SignInPageText(),
                              SizedBox(height: 40),
                              PhoneInputSection(),

                              SizedBox(height: 24),
                              OrDivider(),
                              SizedBox(height: 24),
                              CustomSocialButton(
                                text: 'Continue with Google',
                                image: 'assets/icons/google_icon.png',
                                isLoading: provider.isLoading,
                                onPressed: () {
                                  provider.regUsingGoogleAcc(context);
                                },
                              ),

                              SizedBox(height: 16),
                              CustomSocialButton(
                                text: 'Use Email to Continue',
                                image: 'assets/icons/email_icon.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPageEmail(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (provider.isLoadingPhone || provider.isLoading)
                Container(
                  color: AppColors.black.withAlpha((0.5 * 255).toInt()),
                  child: Center(
                    child: Lottie.asset(
                      'assets/animations/Glow loading.json',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
