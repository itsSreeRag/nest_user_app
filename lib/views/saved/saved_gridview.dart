import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/favorite_provider/favorite_provider.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_main.dart';
import 'package:provider/provider.dart';
import 'package:nest_user_app/widgets/hotel_card.dart';

class SavedHotelsGrid extends StatelessWidget {
  const SavedHotelsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    // Filter only favorite hotels
    final favoriteHotels =
        hotelProvider.filteredHotels.where((hotel) {
          return favoriteProvider.favoriteHotelIds.contains(hotel.profileId);
        }).toList();

    if (favoriteProvider.isLoading || hotelProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (favoriteHotels.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 64, color:  AppColors.grey400),
            const SizedBox(height: 16),
            Text(
              'No saved hotels yet',
              style: TextStyle(fontSize: 16, color: AppColors.grey600),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: favoriteHotels.length,
      itemBuilder: (context, index) {
        final hotel = favoriteHotels[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => HotelDetailsScreen(hotelId: hotel.profileId),
              ),
            );
          },
          child: HotelCard(
            imageUrl: hotel.images.first,
            hotelName: hotel.stayName,
            location: hotel.city,
            rating: 4.5,
            price: hotel.state,
            hotelId: hotel.profileId,
          ),
        );
      },
    );
  }
}
