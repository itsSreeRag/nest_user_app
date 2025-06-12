// widgets/room_details_card.dart
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/views/booking/booking_details/widgets/detail_row.dart';
import 'package:nest_user_app/views/room_details/room_details_main.dart';

class RoomDetailsCard extends StatelessWidget {
  final BookingModel booking;

  const RoomDetailsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.bed, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Room Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DetailRow(label: 'Room Name', value: booking.roomName),
            DetailRow(label: 'Room Type', value: booking.roomType),
            DetailRow(label: 'Bed Type', value: booking.bedType),
            DetailRow(label: 'Check-in Time', value: booking.checkInTime),
            DetailRow(label: 'Check-out Time', value: booking.checkOutTime),

            InkWell(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => RoomDetailsMain(
                            roomId:booking.roomId ,
                          ),
                    ),
                  ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey300),
                  color: AppColors.grey.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'View Room Details',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
