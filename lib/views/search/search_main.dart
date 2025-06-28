import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:nest_user_app/views/hotel_details/hotel_details_main.dart';
import 'package:nest_user_app/widgets/hotel_card.dart';
import 'package:provider/provider.dart';
import 'package:nest_user_app/constants/colors.dart';

class SearchMainPage extends StatelessWidget {
  const SearchMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HotelProvider>(context, listen: false);
    final TextEditingController searchController = TextEditingController();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          provider.clearSearchAndText(searchController);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              // Search Bar
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey300, width: 3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: provider.searchHotels,
                        decoration: const InputDecoration(
                          hintText: "Search by name or address",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 7),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    color: AppColors.background,
                    icon: const Icon(Icons.sort),
                    onSelected: (value) {
                      if (value == 'low_to_high') {
                        Provider.of<HotelProvider>(
                          context,
                          listen: false,
                        ).sortHotelsByPriceAscending();
                      } else if (value == 'high_to_low') {
                        Provider.of<HotelProvider>(
                          context,
                          listen: false,
                        ).sortHotelsByPriceDescending();
                      }
                    },
                    itemBuilder:
                        (BuildContext context) => [
                          const PopupMenuItem(
                            
                            value: 'low_to_high',
                            child: Text('Price: Low to High'),
                          ),
                          const PopupMenuItem(
                            value: 'high_to_low',
                            child: Text('Price: High to Low'),
                          ),
                        ],
                  ),
                ],
              ),

              SizedBox(height: 10),
              // Grid View
              Expanded(
                child: Consumer<HotelProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (provider.filteredHotels.isEmpty) {
                      return const Center(child: Text("No hotels found"));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.8,
                              ),
                          itemCount: provider.filteredHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = provider.filteredHotels[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => HotelDetailsScreen(
                                          hotelId: hotel.profileId,
                                        ),
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
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
