import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/room_detaila_image_section/room_detail_list_images.dart';
import 'package:readmore/readmore.dart';

class RoomDetailsHeading extends StatelessWidget {
  final RoomModel roomData;
  const RoomDetailsHeading({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          roomData.roomName,
          style: TextStyle(
            fontSize: 22,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Type',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: AppColors.grey600),
                ),
                const SizedBox(height: 4.0),
                Text(
                  roomData.roomType,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  roomData.roomTypeDescription,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondary.withAlpha(200),
                    AppColors.secondary.withAlpha(150),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withAlpha(100),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.currency_rupee, color: AppColors.white, size: 25),
                  const SizedBox(width: 4),
                  Text(
                    roomData.basePrice.toString(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  // Text(
                  //   '/day',
                  //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  //     fontWeight: FontWeight.w500,
                  //     color: AppColors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),

        RoomDetailListImages(roomData: roomData),
        // SizedBox(height: ),
        Text(
          'Room Summary',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ReadMoreText(
          roomData.roomDescription,
          trimLines: 3,
          colorClickableText: AppColors.primary,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...See more',
          trimExpandedText: ' See less',
          style: TextStyle(fontSize: 16),
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
