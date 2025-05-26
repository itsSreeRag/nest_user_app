import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/booking_section_main.dart';
import 'package:nest_user_app/views/room_details/room_detail_info/room_detail_info_card.dart';
import 'package:nest_user_app/views/room_details/room_detaila_image_section/room_detail_image_section.dart';
import 'package:nest_user_app/views/room_details/room_features_section/room_detail_feature_section.dart';
import 'package:nest_user_app/widgets/my_button.dart';

class RoomDetailsMain extends StatelessWidget {
  final RoomModel roomData;
  const RoomDetailsMain({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RoomDetailImageSection(roomData: roomData),

            RoomInfoDetailCard(roomData: roomData),

            RoomDetailFeatureSection(roomData: roomData),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MyCustomButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingSectionMain()),
            );
          },
          backgroundcolor: AppColors.primary,
          textcolor: AppColors.white,
          text: 'Book Now',
        ),
      ),
    );
  }
}
