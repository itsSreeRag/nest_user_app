// // booking_details_page.dart
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/booking_status_card.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/booking_timeline_card.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/guest_info_card.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/hotel_info_card.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/payment_info_card.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/room_details.dart';

class BookingDetailsPage extends StatelessWidget {
  final BookingModel booking;

  const BookingDetailsPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor:AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStatusCard(booking: booking),
            const SizedBox(height: 16),

            HotelInfoCard(booking: booking),
            const SizedBox(height: 16),

            RoomDetailsCard(booking: booking),
            const SizedBox(height: 16),

            BookingTimelineCard(booking: booking),
            const SizedBox(height: 16),

            GuestInfoCard(booking: booking),
            const SizedBox(height: 16),

            PaymentInfoCard(booking: booking),
          ],
        ),
      ),
    );
  }
}
