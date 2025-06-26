import 'package:flutter/material.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_main.dart';
import 'package:nest_user_app/widgets/hotel_card.dart';
import 'package:provider/provider.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';

class ExploreByCityMain extends StatelessWidget {
  final String city;
  const ExploreByCityMain({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in $city'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Consumer<HotelProvider>(
        builder: (context, provider, child) {
          final cityHotels =
              provider.hotels
                  .where(
                    (hotel) => hotel.city.toLowerCase() == city.toLowerCase(),
                  )
                  .toList();

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cityHotels.isEmpty) {
            return const Center(child: Text("No hotels found in this city."));
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: cityHotels.length,
              itemBuilder: (context, index) {
                final hotel = cityHotels[index];
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
                    price: hotel.state,
                    hotelId: hotel.profileId,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
