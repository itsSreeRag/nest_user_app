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
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );

    return FutureBuilder(
      future: Future.wait([
        hotelProvider.fetchHotels(),
        favoriteProvider.initialize(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(child: HomeContentWithConsumers()),
        );
      },
    );
  }
}

class HomeContentWithConsumers extends StatelessWidget {
  const HomeContentWithConsumers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const HomeLocationDetails(),
        HomePageSearchBar(onChanged: (value) {}),

        // Show Offers Carousel
        Consumer<HomeAnimationProvider>(
          builder:
              (context, anim, _) => SlideFadeAnimation(
                trigger: anim.showSearchByCity,
                beginOffset: const Offset(0.2, 0),
                child: const HomeOfferCarousel(),
              ),
        ),

        // Show Search by City
        Consumer<HomeAnimationProvider>(
          builder:
              (context, anim, _) => SlideFadeAnimation(
                trigger: anim.showNearHotels,
                beginOffset: const Offset(0, 0.2),
                child: const HomeSearchByCity(),
              ),
        ),

        // Show Nearby Hotels
        Consumer<HomeAnimationProvider>(
          builder:
              (context, anim, _) => SlideFadeAnimation(
                trigger: anim.showRatedHotels,
                beginOffset: const Offset(0.2, 0),
                child: const HomePageNearHotels(),
              ),
        ),

        // Show Suggested Hotels
        Consumer<HomeAnimationProvider>(
          builder:
              (context, anim, _) => SlideFadeAnimation(
                trigger: anim.showRatedHotels,
                beginOffset: const Offset(0, 0.2),
                child: const SuggestedHotels(),
              ),
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
