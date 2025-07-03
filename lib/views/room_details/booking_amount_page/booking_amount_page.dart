import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
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
    final bookingProvider = context.watch<BookingProvider>();
    final totalAmount = bookingProvider.totalAmount;

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    '₹${totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BookingSummaryCard(roomData: roomData),
                const SizedBox(height: 50),
                const SecurityNote(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyCustomButton(
          onPressed: () async {
            final bookingProvider = context.read<BookingProvider>();
            final amount = bookingProvider.totalAmount;

            if (amount == null || amount <= 0) {
              _showSnackBar(context, 'Please select a valid date range first.');
              return;
            }

            await bookingProvider.bookRoom(
              context: context,
              hotelId: hotelData.uid,
              hotelData: hotelData,
              roomData: roomData,
              roomId: roomData.roomId!,
            );

            context.read<DateRangeProvider>().clearDateRange();
            context.read<PersonCountProvider>().clearPersonData();
          },
          text: 'Proceed to Pay ₹${totalAmount?.toStringAsFixed(2) ?? '0.00'}',
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.red,
      ),
    );
  }
}
