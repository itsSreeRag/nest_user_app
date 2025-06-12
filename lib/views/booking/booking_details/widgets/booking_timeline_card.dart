import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/booking_utils.dart';

class BookingTimelineCard extends StatelessWidget {
  final BookingModel booking;

  const BookingTimelineCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    int nights = booking.checkOutDate.difference(booking.checkInDate).inDays;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color:AppColors.primary, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Stay Duration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateColumn(
                    'CHECK-IN',
                    BookingUtils.formatDate(booking.checkInDate),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$nights ${nights == 1 ? 'Night' : 'Nights'}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildDateColumn(
                    'CHECK-OUT',
                    BookingUtils.formatDate(booking.checkOutDate),
                    isCheckOut: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateColumn(String label, String date, {bool isCheckOut = false}) {
    return Column(
      crossAxisAlignment: isCheckOut ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}