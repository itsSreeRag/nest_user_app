import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class TileSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData trailicon;
  final IconData leadicon;
  final Color color;
  final VoidCallback ontap;
  const TileSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailicon,
    required this.leadicon,
    required this.color,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: color.withAlpha(9),
          child: Icon(leadicon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style:  TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(trailicon, size: 16, color: AppColors.grey),
        ),
      ),
    );
  }
}