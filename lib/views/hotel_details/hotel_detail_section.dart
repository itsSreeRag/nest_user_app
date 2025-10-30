import 'package:flutter/material.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/views/hotel_details/widgets/discover_button.dart';
import 'package:nest_user_app/views/hotel_details/widgets/hotel_description_widget.dart';
import 'package:nest_user_app/views/hotel_details/widgets/location_card_widget.dart';
import 'package:nest_user_app/views/hotel_details/widgets/price_tag_widget.dart';
import 'package:nest_user_app/views/hotel_details/widgets/section_heder_widget.dart';

class HotelDetailSection extends StatelessWidget {
  final HotelModel hotelData;
  const HotelDetailSection({super.key, required this.hotelData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Section
          SectionHeaderWidget(
            title: 'About the Hotel',
            icon: Icons.info_outline,
          ),
          const SizedBox(height: 12),
          HotelDescriptionWidget(description: hotelData.hotelDescription),
          const SizedBox(height: 24),
          // Price Section
          SectionHeaderWidget(
            title: 'Starting Price',
            icon: Icons.currency_rupee,
          ),
          const SizedBox(height: 12),
          PriceTagWidget(basePrice: hotelData.basePrice),
          const SizedBox(height: 24),
          // Address Section
          SectionHeaderWidget(
            title: 'Location',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 12),
          LocationCardWidget(
            city: hotelData.city,
            state: hotelData.state,
            country: hotelData.country,
          ),
          SizedBox(height: 20),
          // AI Tourist Spots Button
          DiscoverButton(city: hotelData.city),
        ],
      ),
    );
  }
}
