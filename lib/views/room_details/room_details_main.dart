import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/room_provider/room_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/new_room_details.dart';
import 'package:nest_user_app/views/room_details/room_detail_image.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/booking_section_main.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:provider/provider.dart';

class RoomDetailsMain extends StatelessWidget {
  final String roomId;
  final HotelModel? hotelData;

  const RoomDetailsMain({super.key, required this.roomId, this.hotelData});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);

    final RoomModel roomData = roomProvider.rooms.firstWhere(
      (room) => room.roomId == roomId,
    );

    return Scaffold(
      body: Stack(
        children: [
          RoomDetailImage(roomData: roomData),
          RoomDetailSection(roomData: roomData),
        ],
      ),
      bottomNavigationBar:
          hotelData != null
              ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: MyCustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BookingSectionMain(
                              hotelData: hotelData!,
                              roomData: roomData,
                            ),
                      ),
                    );
                  },
                  backgroundcolor: AppColors.primary,
                  textcolor: AppColors.white,
                  text: 'Book Now',
                ),
              )
              : const SizedBox(),
    );
  }
}
