import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/views/booking/booking_card/widgets/booking_card_cancel_button.dart';
import 'package:nest_user_app/views/booking/booking_card/widgets/booking_card_info_section.dart';
import 'package:nest_user_app/views/booking/booking_card/widgets/booking_data_section.dart';
import 'package:nest_user_app/views/booking/booking_card/widgets/booking_header.dart';
import 'package:nest_user_app/views/booking/booking_card/widgets/booking_location_section.dart';

class BookingsCard extends StatelessWidget {
  final BookingModel booking;

  const BookingsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingHeader(
                hotelName: booking.hotelName,
                bookingId: booking.bookingId,
                roomName: booking.roomName,
              ),
              DateSection(
                checkIn: booking.checkInDate,
                checkOut: booking.checkOutDate,
              ),
              const SizedBox(height: 20),
              LocationSection(location: booking.hotelAddress),
              const SizedBox(height: 16),
              GuestInfoSection(
                adults: booking.adults,
                children: booking.children,
              ),
              const SizedBox(height: 24),
              if (booking.bookingStatus == 'Booked')
                CancelButton(booking: booking),
            ],
          ),
        ),
      ),
    );
  }
}
