import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/new_room_detail_show/new_room_details_info_card.dart';

class RoomDetailBasicInfo extends StatelessWidget {
  final RoomModel roomData;

  const RoomDetailBasicInfo({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Informations',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // GridView for info items
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          padding: EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.8,
          children: [
            RoomDetaiInfolItem(
              label: 'Room Area',
              value: roomData.roomArea,
              icon: Icons.square_foot,
              unit: 'sqft',
            ),
            RoomDetaiInfolItem(
              label: 'Bed Type',
              value: roomData.bedType,
              icon: Icons.bed,
            ),
            RoomDetaiInfolItem(
              label: 'Adults',
              value: roomData.maxAdults,
              icon: Icons.person,
            ),
            RoomDetaiInfolItem(
              label: 'Children',
              value: roomData.maxChildren,
              icon: Icons.child_care,
            ),
          ],
        ),
      ],
    );
  }
}
