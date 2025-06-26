import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/profile/account_page_main.dart';
import 'package:nest_user_app/views/profile/contact_us_page/contact_us_page_main.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/widgets/acc_page_tile_section.dart';

class AccPageMoreOptions extends StatelessWidget {
  const AccPageMoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ContactUsPage()));
            },
            leadicon: Icons.person,
            title: 'Contact Us',
            subtitle: 'Make changes to your account',
            trailicon: Icons.arrow_forward_ios,
            color: AppColors.primary,
          ),
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.share,
            title: 'FAQs',
            subtitle: 'Frequently asked questions',
            trailicon: Icons.arrow_forward_ios,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
