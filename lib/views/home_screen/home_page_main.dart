import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/animation_provider/home_animation.dart';
import 'package:nest_user_app/views/home_screen/home_page.animation.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_location_details.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_hotel_near.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_offer_carousel.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_search_bar.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_search_city.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_rated_hotels.dart';
import 'package:provider/provider.dart';

class HomeScreenMain extends StatelessWidget {
  const HomeScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeAnimationProvider>(
      // Listening to animation state changes
      builder: (context, animProvider, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Displays user location details
                  HomeLocationDetails(),

                  // Search bar for typing queries
                  HomePageSearchBar(onChanged: (value) {}),

                  // Carousel offers with slide-in animation from right
                  SlideFadeAnimation(
                    trigger: animProvider.showSearchByCity,
                    beginOffset: Offset(0.2, 0),
                    child: HomeOfferCarousel(),
                  ),

                  // "Search by City" section with slide-in from bottom
                  SlideFadeAnimation(
                    trigger: animProvider.showNearHotels,
                    beginOffset: const Offset(0, 0.2),
                    child: HomeSearchByCity(),
                  ),

                  // Nearby hotels section with slide-in from right
                  SlideFadeAnimation(
                    trigger: animProvider.showRatedHotels,
                    beginOffset: const Offset(0.2, 0),
                    child: HomePageNearHotels(),
                  ),

                  // Rated hotels section with slide-in from bottom
                  SlideFadeAnimation(
                    trigger: animProvider.showRatedHotels,
                    beginOffset: const Offset(0, 0.2), 
                    child: HomeRatedHotels(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
