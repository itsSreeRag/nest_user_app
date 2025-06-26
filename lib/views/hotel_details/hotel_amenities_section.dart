import 'package:flutter/material.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/views/hotel_details/widgets/hotel_amenities_card.dart';
import 'package:nest_user_app/views/hotel_details/widgets/section_heder_widget.dart';

class HotelAmenitiesSection extends StatelessWidget {
  final HotelModel hotelData;
  const HotelAmenitiesSection({super.key, required this.hotelData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeaderWidget(
              title: 'What is this place offers',
              icon: Icons.local_offer_outlined,
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
              children: [
                if (hotelData.entireProperty)
                  HotelAmenitiesCard(
                    icon: Icons.home_work_outlined,
                    label: 'Entire Property',
                  ),
                if (hotelData.privateProperty)
                  HotelAmenitiesCard(
                    icon: Icons.lock_outline,
                    label: 'Private Property',
                  ),
                if (hotelData.coupleFriendly)
                  HotelAmenitiesCard(
                    icon: Icons.favorite_outline,
                    label: 'Couple Friendly',
                  ),
                if (hotelData.parking)
                  HotelAmenitiesCard(
                    icon: Icons.local_parking_outlined,
                    label: 'Parking',
                  ),
                if (hotelData.freeCancellation)
                  HotelAmenitiesCard(
                    icon: Icons.cancel_outlined,
                    label: 'Free Cancellation',
                  ),
                if (hotelData.restaurantInsideProperty)
                  HotelAmenitiesCard(
                    icon: Icons.restaurant_menu_outlined,
                    label: 'Restaurant Inside',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
