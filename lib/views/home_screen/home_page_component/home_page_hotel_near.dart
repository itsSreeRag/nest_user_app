import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_main.dart';
import 'package:nest_user_app/widgets/hotel_card.dart';
import 'package:provider/provider.dart';

class HomePageNearHotels extends StatelessWidget {
  const HomePageNearHotels({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hotel Near You',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
              ),
            ),
            Text(
              'View All',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 210,
          width: double.infinity,
          child: Consumer<HotelProvider>(
            builder: (context, hotelProvider, _) {
              if (hotelProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (hotelProvider.hotels.isEmpty) {
                return const Center(child: Text("No hotels found."));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotelProvider.hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotelProvider.hotels[index];
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
              );
            },
          ),
        ),
      ],
    );
  }
}
