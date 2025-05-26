import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/room_detaila_image_section/room_detail_list_images.dart';

class RoomDetailImageSection extends StatelessWidget {
  final RoomModel roomData;
  const RoomDetailImageSection({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        roomData.roomImages.isNotEmpty
            ? Image.network(
              roomData.roomImages.first,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            )
            : Container(
              height: 400,
              color: AppColors.grey300,
              child: Icon(Icons.image, size: 50, color: AppColors.grey),
            ),
        const SizedBox(height: 10),
        RoomDetailListImages(roomData: roomData),
        const SizedBox(height: 10),
      ],
    );
  }
}




