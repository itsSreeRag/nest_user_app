import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class BookingHeader extends StatelessWidget {
  final String hotelName;
  final String bookingId;
  final String roomName;

  const BookingHeader({
    super.key,
    required this.hotelName,
    required this.bookingId,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hotelName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(200),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ID: $bookingId',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Text(
          roomName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8,)
      ],
    );
  }
}
