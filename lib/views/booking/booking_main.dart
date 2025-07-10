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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: const Text(
            'My Bookings',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.black54,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: Consumer<BookingProvider>(
          builder: (context, provider, _) {
            if (provider.bookings == null && !provider.isLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await provider.fetchBookings();
              });
            } else if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);

              final upcoming =
                  provider.bookings!.where((b) {
                    final checkOut = DateTime(
                      b.checkOutDate.year,
                      b.checkOutDate.month,
                      b.checkOutDate.day,
                    );

                    return b.bookingStatus == 'Booked' &&
                        checkOut.isAfter(today);
                  }).toList();

              final completed =
                  provider.bookings!.where((b) {
                    final checkOut = DateTime(
                      b.checkOutDate.year,
                      b.checkOutDate.month,
                      b.checkOutDate.day,
                    );

                    return b.bookingStatus == 'Booked' &&
                        checkOut.isBefore(today);
                  }).toList();

              final cancelled =
                  provider.bookings!
                      .where((b) => b.bookingStatus == 'Cancelled')
                      .toList();

              return RefreshIndicator(
                onRefresh: () async {
                  await provider.fetchBookings();
                },
                child: TabBarView(
                  children: [
                    _buildBookingList(
                      context,
                      upcoming,
                      'No upcoming bookings.',
                      cancelButton: true,
                    ),
                    _buildBookingList(
                      context,
                      completed,
                      'No completed bookings.',
                    ),
                    _buildBookingList(
                      context,
                      cancelled,
                      'No cancelled bookings.',
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildBookingList(
    BuildContext context,
    List bookings,
    String emptyMsg, {
    bool cancelButton = false,
  }) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              emptyMsg,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingDetailsPage(booking: booking),
                ),
              );
            },
            child: BookingsCard(booking: booking, cancelBooking: cancelButton),
          );
        },
      ),
    );
  }
}
