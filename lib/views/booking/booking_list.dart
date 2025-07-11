import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/booking/booking_card/booking_card.dart';
import 'package:nest_user_app/views/booking/booking_details/booking_details_main.dart';

class BookingList extends StatelessWidget {
  final List bookings;
  final String emptyMsg;
  final bool cancelButton;

  const BookingList({
    super.key,
    required this.bookings,
    required this.emptyMsg,
    this.cancelButton = false,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, size: 64, color: AppColors.grey400),
            const SizedBox(height: 16),
            Text(
              emptyMsg,
              style: TextStyle(fontSize: 16, color: AppColors.grey600),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetailsPage(booking: booking),
                ),
              );
            },
            child: BookingsCard(booking: booking, cancelBooking: cancelButton),
          );
        },
      ),
    );
  }
}
