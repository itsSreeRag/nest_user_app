import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class HomeLocationDetails extends StatelessWidget {
  const HomeLocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Location',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.secondary, size: 22),
                Text(
                  'Calicut,Kerela',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
        Icon(Icons.notifications, color: AppColors.secondary, size: 25),
      ],
    );
  }
}
