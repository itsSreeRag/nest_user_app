import 'package:flutter/material.dart';

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
          child: Icon(leadicon, color: Colors.blue),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(trailicon, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}