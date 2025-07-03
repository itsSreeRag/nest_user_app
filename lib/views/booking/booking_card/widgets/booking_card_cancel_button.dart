// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';
import 'package:provider/provider.dart';

class CancelButton extends StatelessWidget {
  final BookingModel booking;
  const CancelButton({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => _showCancelDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close, size: 20),
            SizedBox(width: 8),
            Text(
              'Cancel Booking',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Booking'),
          content: const Text('Are you sure you want to cancel this booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                final success = await Provider.of<BookingProvider>(
                  context,
                  listen: false,
                ).cancelBooking(
                  bookingId: booking.bookingId,
                  hotelId: booking.hotelId,
                );

                if (success) {
                  MyCustomSnackBar.show(
                    context: context,
                    title: 'Cancelled',
                    message: 'Booking cancelled successfully.',
                    icon: Icons.cancel,
                    backgroundColor: AppColors.red,
                  );
                  Navigator.pop(context);
                } else {
                  MyCustomSnackBar.show(
                    context: context,
                    title: 'Error',
                    message: 'Failed to cancel booking. Please try again.',
                    icon: Icons.error,
                    backgroundColor: AppColors.red,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }
}
