import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_main.dart';
import 'package:nest_user_app/widgets/hotel_card2.dart';
import 'package:provider/provider.dart';

class HomeRatedHotels extends StatelessWidget {
  const HomeRatedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Highest Rated Hotels',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Consumer<HotelProvider>(
          builder: (context, hotelProvider, child) {
            if (hotelProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (hotelProvider.hotels.isEmpty) {
              return const Center(child: Text("No hotels found."));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: hotelProvider.hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotelProvider.hotels[index];
                return InkWell(
                  onTap: () {
                    log('Strt');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                HotelDetailsScreen(hotelId: hotel.profileId),
                      ),
                    );
                  },
                  child: HotelCard2(
                    imagePath: hotel.profileImage,
                    hotelName: hotel.stayName,
                    location: hotel.state,
                    rating: 4.5,
                    price: hotel.city,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
