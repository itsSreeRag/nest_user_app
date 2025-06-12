import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/views/booking/booking_card/booking_card.dart';
import 'package:nest_user_app/views/booking/booking_details/booking_details_main.dart';
import 'package:provider/provider.dart';

class BookingPageMain extends StatelessWidget {
  const BookingPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingProvider.fetchBookings();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: const Text('My Bookings'),
        centerTitle: true,
      ),
      body: Consumer<BookingProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.bookings.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: provider.bookings.length,
              itemBuilder: (context, index) {
                final booking = provider.bookings[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BookingDetailsPage(booking: booking),
                      ),
                    );
                  },
                  child: BookingsCard(booking: booking),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
