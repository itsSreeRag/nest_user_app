import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/animation_provider/home_animation.dart';
import 'package:nest_user_app/controllers/favorite_provider/favorite_provider.dart';
import 'package:nest_user_app/controllers/hotel_provider/hotel_provider.dart';
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
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

    return FutureBuilder(
      future: Future.wait([
         hotelProvider.initFuture,
        favoriteProvider.initFuture,
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Consumer<HomeAnimationProvider>(
          builder: (context, animProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    HomeLocationDetails(),
                    HomePageSearchBar(onChanged: (value) {}),
                    SlideFadeAnimation(
                      trigger: animProvider.showSearchByCity,
                      beginOffset: const Offset(0.2, 0),
                      child: HomeOfferCarousel(),
                    ),
                    SlideFadeAnimation(
                      trigger: animProvider.showNearHotels,
                      beginOffset: const Offset(0, 0.2),
                      child: HomeSearchByCity(),
                    ),
                    SlideFadeAnimation(
                      trigger: animProvider.showRatedHotels,
                      beginOffset: const Offset(0.2, 0),
                      child: HomePageNearHotels(),
                    ),
                    SlideFadeAnimation(
                      trigger: animProvider.showRatedHotels,
                      beginOffset: const Offset(0, 0.2),
                      child: SuggestedHotels(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
