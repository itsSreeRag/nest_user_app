import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
import 'package:provider/provider.dart';

class HomeOfferCarousel extends StatelessWidget {
  const HomeOfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelProvider>(
      builder: (context, hotelProvider, child) {
        if (hotelProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (hotelProvider.hotels.isEmpty) {
          return const Center(child: Text("No hotels found."));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            // const Text(
            //   'Best Offer For You',
            //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 5),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 2.2,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 1,
              ),
              items:
                  hotelProvider.hotels.map((e) {
                    return Builder(
                      builder:
                          (context) => SizedBox(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                e.profileImage,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                        value:
                                            loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image),
                                  );
                                },
                              ),
                            ),
                          ),
                    );
                  }).toList(),
            ),
          ],
        );
      },
    );
  }
}
