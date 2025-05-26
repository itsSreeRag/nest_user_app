import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_location_details.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_hotel_near.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_offer_carousel.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_search_bar.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_search_city.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_rated_hotels.dart';

class HomeScreenMain extends StatelessWidget {
  const HomeScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeLocationDetails(),

                  HomePageSearchBar(onChanged: (value) {}),

                  HomeOfferCarousel(),

                  HomeSearchByCity(),

                  HomePageNearHotels(),

                  HomeRatedHotels(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
