import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class LocationSection extends StatelessWidget {
  final String location;

  const LocationSection({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, size: 20,color: AppColors.secondary,),
        SizedBox(width: 8),
        Expanded(
          // 👈 this solves the overflow
          child: Text(
            location,
            style: TextStyle(
              fontSize: 16,
              color:AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
