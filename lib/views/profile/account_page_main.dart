import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/widgets/account_page_options_section.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/account_page_profile_section.dart';

class AccountPageMain extends StatelessWidget {
  const AccountPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('My Profile', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileSection(),
                AccountPageOptions(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
