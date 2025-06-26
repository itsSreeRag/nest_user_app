import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:nest_user_app/controllers/favorite_provider/favorite_provider.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/views/hotel_details/widgets/image_carousel.dart';
import 'package:nest_user_app/views/hotel_details/widgets/top_controls.dart';
import 'package:nest_user_app/views/hotel_details/widgets/indicator_and_info.dart';

class HotelDetailsImageSection extends StatelessWidget {
  const HotelDetailsImageSection({super.key, required this.hotelData});
  final HotelModel hotelData;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final isFav = context.watch<FavoriteProvider>().isFavorite(
      hotelData.profileId,
    );

    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha((0.3 * 255).toInt()),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        child: Stack(
          children: [
            ImageCarousel(pageController: pageController, hotelData: hotelData),
            TopControls(
              fadeAnimation: const AlwaysStoppedAnimation(1.0),
              isFav: isFav,
              hotelId: hotelData.profileId,
            ),
            IndicatorAndInfo(
              fadeAnimation: const AlwaysStoppedAnimation(1.0),
              slideAnimation: const AlwaysStoppedAnimation(Offset.zero),
              pageController: pageController,
              hotelData: hotelData,
            ),
          ],
        ),
      ),
    );
  }
}
