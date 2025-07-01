import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/views/hotel_details/contact_details_section.dart';
import 'package:nest_user_app/views/hotel_details/hotal_available_room_list.dart';
import 'package:nest_user_app/views/hotel_details/hotel_detail_section.dart';
import 'package:nest_user_app/views/hotel_details/hotel_amenities_section.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_image_section.dart';
import 'package:nest_user_app/views/hotel_details/hotel_review_report.dart';
import 'package:provider/provider.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String hotelId;
  const HotelDetailsScreen({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final hotelprovider = Provider.of<HotelProvider>(listen: false, context);
    final HotelModel hotelData = hotelprovider.hotels.firstWhere(
      (h) => h.profileId == hotelId,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotelDetailsImageSection(hotelData: hotelData),

            HotelDetailSection(hotelData: hotelData),

            HotelAmenitiesSection(hotelData: hotelData),
            SizedBox(height: 10),

            HotelAvailableRoomsList(hotelData: hotelData),
            ContactDetailsWidget(
              phoneNumber: hotelData.contactNumber,
              email: hotelData.email,
            ),

            SizedBox(height: 20),

            HotelReviewReport(hotelId: hotelId),
          ],
        ),
      ),
    );
  }
}
