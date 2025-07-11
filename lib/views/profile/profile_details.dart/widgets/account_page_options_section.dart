import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/acc_page_more_options.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/acc_page_settings.dart';

class AccountPageOptions extends StatelessWidget {
  const AccountPageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            AccPageSettings(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'More',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            AccPageMoreOptions(),
          ],
        ),
      ),
    );
  }
}