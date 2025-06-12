import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/booking_amount_page.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/date_card_section.dart';
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
            child: Column(children: [DateCardSection()]),
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
            final selectedRange = dateProvider.selectedDateRange;
            final bookingProvider = Provider.of<BookingProvider>(
              context,
              listen: false,
            );

            if (selectedRange == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Please select a date range before proceeding.',
                  ),
                  backgroundColor: AppColors.red,
                ),
              );
              return;
            } else {
              await bookingProvider.calculateAmount(
                dateRangeProvider: dateProvider,
                roomData: roomData,
              );

              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BookingAmountPage(
                        hotelData: hotelData,
                        roomData: roomData,
                      ),
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
