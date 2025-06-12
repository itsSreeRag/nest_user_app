// widgets/booking_status_card.dart
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/booking_utils.dart';

class BookingStatusCard extends StatelessWidget {
  final BookingModel booking;

  const BookingStatusCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    Color statusColor = BookingUtils.getStatusColor(booking.bookingStatus);
    Color paymentColor = BookingUtils.getPaymentStatusColor(
      booking.paymentStatus,
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking ID: ${booking.bookingId}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    booking.bookingStatus.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.payment, size: 16, color: paymentColor),
                const SizedBox(width: 4),
                Text(
                  'Payment: ${booking.paymentStatus}',
                  style: TextStyle(
                    color: paymentColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Booked on: ${BookingUtils.formatDate(booking.bookingDate)}',
              style: TextStyle(color: AppColors.grey600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
