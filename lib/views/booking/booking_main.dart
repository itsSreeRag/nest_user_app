import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/views/booking/booking_list.dart';
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
                    BookingList(
                      bookings: upcoming,
                      emptyMsg: 'No upcoming bookings.',
                      cancelButton: true,
                    ),
                    BookingList(
                      bookings: completed,
                      emptyMsg: 'No completed bookings.',
                    ),
                    BookingList(
                      bookings: cancelled,
                      emptyMsg: 'No cancelled bookings.',
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
}
