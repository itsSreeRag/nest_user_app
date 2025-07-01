import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:nest_user_app/controllers/location_provider/location_provider.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_main.dart';
import 'package:nest_user_app/widgets/hotel_card.dart';
import 'package:provider/provider.dart';

class HomePageNearHotels extends StatelessWidget {
  const HomePageNearHotels({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HotelProvider, LocationProvider>(
      builder: (context, hotelProvider, locationProvider, _) {
        if (hotelProvider.isLoading || locationProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List filteredHotels;

        if (locationProvider.city != null &&
            locationProvider.city!.trim().isNotEmpty) {
          filteredHotels =
              hotelProvider.hotels.where((hotel) {
                return hotel.city.toLowerCase().trim() ==
                    locationProvider.city!.toLowerCase().trim();
              }).toList();
        } else {
          // No location, show all hotels
          filteredHotels = hotelProvider.hotels;
        }

        if (filteredHotels.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                (locationProvider.city!.isEmpty)
                    ? 'All Hotels'
                    : 'Hotels in ${locationProvider.city}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black87,
                ),
              ),
              SizedBox(
                height: 210,
                child: const Center(child: Text("No hotels found.")),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              (locationProvider.city!.isEmpty)
                  ? 'All Hotels'
                  : 'Hotels in ${locationProvider.city}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 210,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  HotelDetailsScreen(hotelId: hotel.profileId),
                        ),
                      );
                    },
                    child: HotelCard(
                      imageUrl: hotel.images.first,
                      hotelName: hotel.stayName,
                      location: hotel.city,
                      rating: 4.5,
                      price: hotel.basePrice,
                      hotelId: hotel.profileId,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
