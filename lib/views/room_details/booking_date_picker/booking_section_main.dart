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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const DateCardSection(),
                const SizedBox(height: 16),
                const PersonCountCardSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyCustomButton(
          onPressed: () async {
            final dateProvider = Provider.of<DateRangeProvider>(
              context,
              listen: false,
            );
            final personCountProvider = Provider.of<PersonCountProvider>(
              context,
              listen: false,
            );
            final bookingProvider = Provider.of<BookingProvider>(
              context,
              listen: false,
            );

            final selectedRange = dateProvider.selectedDateRange;

            // Validate date selection
            if (selectedRange == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Please select a date range before proceeding.',
                  ),
                  backgroundColor: AppColors.red,
                ),
              );
              return;
            }

            // Validate person count
            if (personCountProvider.totalCount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select at least one person.'),
                  backgroundColor: AppColors.red,
                ),
              );
              return;
            }

            // 🔽 FIRST: Check availability
            final isAvailable = await bookingProvider.checkRoomAvailability(
              hotelId: hotelData.profileId,
              roomId: roomData.roomId!,
              roomData: roomData,
              dateRangeProvider: dateProvider,
              personCountProvider: personCountProvider,
            );

            if (!isAvailable) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Selected room is not available for given date/person count.',
                  ),
                  backgroundColor: AppColors.red,
                ),
              );
              return;
            }

            // ✅ THEN: Calculate amount
            try {
              await bookingProvider.calculateAmount(
                dateRangeProvider: dateProvider,
                personCountProvider: personCountProvider,
                roomData: roomData,
                hotelId: hotelData.profileId,
                roomId: roomData.roomId!,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BookingAmountPage(
                        hotelData: hotelData,
                        roomData: roomData,
                      ),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error calculating booking amount: ${e.toString()}',
                  ),
                  backgroundColor: AppColors.red,
                ),
              );
            }
          },
          text: 'Next',
        ),
      ),
    );
  }
}
