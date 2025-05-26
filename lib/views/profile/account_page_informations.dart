import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class AccountInformations extends StatelessWidget {
  const AccountInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 100,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          AccountPageItemsCard(
            title: 'Settings',
            prefiXIcon: Icons.settings,
            sufixIcon: Icons.arrow_forward_ios,
          ),
          AccountPageItemsCard(
            title: 'Settings',
            prefiXIcon: Icons.settings,
            sufixIcon: Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}

class AccountPageItemsCard extends StatelessWidget {
  final String title;
  final IconData prefiXIcon;
  final IconData sufixIcon;
  const AccountPageItemsCard({
    super.key,
    required this.title,
    required this.prefiXIcon,
    required this.sufixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey300)),
      ),
      padding: EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(prefiXIcon, color: AppColors.grey600),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey600),
      ),
    );
  }
}
