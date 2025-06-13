import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/profile/account_page_main.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/widgets/acc_page_tile_section.dart';

class AccPageSettings extends StatelessWidget {
  const AccPageSettings({super.key});

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
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.person,
            title: 'My Account ',
            subtitle: 'Make changes to your account',
            trailicon: Icons.arrow_forward_ios,
            color: Color(0xff0601B4),
          ),
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.share,
            title: 'Share',
            subtitle: 'Share the app with friends',
            trailicon: Icons.arrow_forward_ios,
            color: Color(0xff0601B4),
          ),
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.share,
            title: 'Share',
            subtitle: 'Share the app with friends',
            trailicon: Icons.arrow_forward_ios,
            color: Color(0xff0601B4),
          ),
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.security,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            trailicon: Icons.arrow_forward_ios,
            color: Color(0xff0601B4),
          ),
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.file_copy,
            title: 'Terms&Conditions',
            subtitle: 'View terms of service',
            trailicon: Icons.arrow_forward_ios,
            color: Color(0xff0601B4),
          ),
          TileSection(
            ontap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SampleScreen()));
            },
            leadicon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out of your Account',
            trailicon: Icons.arrow_forward_ios,
            color: Color(0xff0601B4),
          ),
        ],
      ),
    );
  }
}