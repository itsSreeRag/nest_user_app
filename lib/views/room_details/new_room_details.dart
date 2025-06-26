import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/new_room_detail_show/new_room_details_feature_section.dart';
import 'package:nest_user_app/views/room_details/new_room_detail_show/new_room_details_heading.dart';
import 'package:nest_user_app/views/room_details/new_room_detail_show/room_details_basic_info.dart';

class RoomDetailSection extends StatelessWidget {
  final RoomModel roomData;
  const RoomDetailSection({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // room detail heading
                  RoomDetailsHeading(roomData: roomData),
                  SizedBox(height: 10),
                  RoomDetailBasicInfo(roomData: roomData),
                  RoomDetailFeatureSection(roomData: roomData,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
