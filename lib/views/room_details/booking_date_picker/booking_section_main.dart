// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/booking_amount_page.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/date_card_section.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/person_count_card.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';
import 'package:provider/provider.dart';

class BookingSectionMain extends StatelessWidget {
  final RoomModel roomData;
  final HotelModel hotelData;

  const BookingSectionMain({
    super.key,
    required this.roomData,
    required this.hotelData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.background,),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                DateCardSection(),
                SizedBox(height: 16),
                PersonCountCardSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyCustomButton(
          onPressed: () async {
            final dateProvider = context.read<DateRangeProvider>();
            final personCountProvider = context.read<PersonCountProvider>();
            final bookingProvider = context.read<BookingProvider>();

            final selectedRange = dateProvider.selectedDateRange;

            // Date range validation
            if (selectedRange == null) {
              _showSnackBar(context, 'Please select a date range before proceeding.');
              return;
            }

            // Person count validation
            if (personCountProvider.totalCount <= 0) {
              _showSnackBar(context, 'Please select at least one person.');
              return;
            }

            // Try calculating availability and amount using new logic
            final success = await bookingProvider.calculateAmountAndAvailability(
              hotelId: hotelData.profileId,
              roomId: roomData.roomId!,
              roomData: roomData,
              dateRangeProvider: dateProvider,
              personCountProvider: personCountProvider,
            );

            if (!success) {
              _showSnackBar(
                context,
                'Room is not available for the selected dates and person count.',
              );
              return;
            }

            // If all good, navigate to amount page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingAmountPage(
                  hotelData: hotelData,
                  roomData: roomData,
                ),
              ),
            );
          },
          text: 'Next',
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    MyCustomSnackBar.show(
        context: context,
        title: 'Error',
        message: message,
        icon: Icons.check_circle,
        backgroundColor: AppColors.green,
      );
  }
}
