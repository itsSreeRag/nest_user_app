import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:provider/provider.dart';

class BookingSummaryCard extends StatelessWidget {
  final RoomModel roomData;

  const BookingSummaryCard({
    super.key,
    required this.roomData,
  });

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final personCountProvider = context.watch<PersonCountProvider>();

    final int? amount = bookingProvider.totalAmount;
    final int adultCount = bookingProvider.adultCount ?? personCountProvider.adultCount;
    final int childrenCount = bookingProvider.childrenCount ?? personCountProvider.childrenCount;
    final int totalGuests = adultCount + childrenCount;

    final int maxAdultsPerRoom = int.tryParse(roomData.maxAdults) ?? 1;
    final int maxChildrenPerRoom = int.tryParse(roomData.maxChildren) ?? 0;

    final int requiredRooms = bookingProvider.requiredRooms ??
        personCountProvider.calculateRequiredRooms(
          maxAdultsPerRoom: maxAdultsPerRoom,
          maxChildrenPerRoom: maxChildrenPerRoom,
        );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Room & Guest Information
          _buildSectionHeader('Room & Guest Details'),
          const SizedBox(height: 8),
          _buildDetailRow('Adults', '$adultCount'),
          const SizedBox(height: 4),
          _buildDetailRow('Children', '$childrenCount'),
          const SizedBox(height: 4),
          _buildDetailRow('Total Guests', '$totalGuests'),
          const SizedBox(height: 8),
          _buildDetailRow(
            'Rooms Required',
            '$requiredRooms ${requiredRooms == 1 ? 'Room' : 'Rooms'}',
            isHighlight: true,
          ),
          const SizedBox(height: 4),
          _buildCapacityInfo(maxAdultsPerRoom, maxChildrenPerRoom),

          const SizedBox(height: 16),

          // Payment Details
          _buildSectionHeader('Payment Details'),
          const SizedBox(height: 8),
          _buildDetailRow('Service Amount', '₹${amount?.toStringAsFixed(2) ?? '0.00'}'),
          const SizedBox(height: 4),
          _buildDetailRow('Tax & Fees', '₹0.00'),
          const SizedBox(height: 12),
          Divider(color: AppColors.grey),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Total Amount',
            '₹${amount?.toStringAsFixed(2) ?? '0.00'}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isTotal = false, bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal
                ? AppColors.black87
                : (isHighlight ? AppColors.primary : AppColors.grey600),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : (isHighlight ? FontWeight.w600 : FontWeight.w500),
            color: isHighlight ? AppColors.primary : AppColors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCapacityInfo(int maxAdults, int maxChildren) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Per Room Capacity',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: AppColors.grey600,
          ),
        ),
        Text(
          '$maxAdults Adults${maxChildren > 0 ? ', $maxChildren Children' : ''}',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }
}
