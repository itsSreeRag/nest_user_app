import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/widgets/booking_summary_card.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/widgets/payment_icon.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/widgets/security_note.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:provider/provider.dart';

class BookingAmountPage extends StatelessWidget {
  final HotelModel hotelData;
  final RoomModel roomData;
  const BookingAmountPage({
    super.key,
    required this.hotelData,
    required this.roomData,
  });

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Payment Summary',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.black87,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const PaymentIcon(),
              const SizedBox(height: 32),
              Text(
                'Amount to Pay',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // Amount
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha(80),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '₹${bookingProvider.amount?.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const BookingSummaryCard(),
              const SizedBox(height: 50),
              const SecurityNote(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyCustomButton(
          onPressed: () async {
            final bookingProvider = Provider.of<BookingProvider>(
              context,
              listen: false,
            );
            final amount = bookingProvider.amount;

            if (amount == null || amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a valid date range first'),
                ),
              );
              return;
            }

            await bookingProvider.bookRoom(
              context: context,
              hotelData: hotelData,
              roomData: roomData,
              hotelId: hotelData.uid,
              roomId: roomData.roomId!,
            );
          },
          text: 'Proceed to Pay ₹${bookingProvider.amount?.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
