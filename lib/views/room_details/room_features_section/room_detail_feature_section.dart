import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/room_features_section/feature_category_section.dart';

class RoomDetailFeatureSection extends StatelessWidget {
  const RoomDetailFeatureSection({super.key, required this.roomData});

  final RoomModel roomData;

  @override
  Widget build(BuildContext context) {
    final diningFeatures = [
      FeatureItem(
        'Free Breakfast',
        roomData.freeBreakfast,
        Icons.breakfast_dining,
      ),
      FeatureItem('Free Lunch', roomData.freeLunch, Icons.lunch_dining),
      FeatureItem('Free Dinner', roomData.freeDinner, Icons.dinner_dining),
    ];

    final roomFeatures = [
      FeatureItem('Cupboard', roomData.cupboard, Icons.door_sliding),
      FeatureItem('Wardrobe', roomData.wardrobe, Icons.door_front_door),
      FeatureItem('Air Conditioner', roomData.airConditioner, Icons.ac_unit),
      FeatureItem('Kitchen', roomData.kitchen, Icons.kitchen),
      FeatureItem('Swimming Pool', roomData.swimmingPool, Icons.pool),
    ];

    final serviceFeatures = [
      FeatureItem('Wifi', roomData.wifi, Icons.wifi),
      FeatureItem('Parking', roomData.parking, Icons.local_parking),
      FeatureItem('Elevator', roomData.elevator, Icons.elevator),
      FeatureItem('Laundry', roomData.laundry, Icons.local_laundry_service),
      FeatureItem(
        'House Keeping',
        roomData.houseKeeping,
        Icons.cleaning_services,
      ),
    ];

    final policy = [
      FeatureItem('Smoking Allowded', roomData.smokingAllowed, Icons.block),
      FeatureItem('Pets Allowded', roomData.petsAllowed, Icons.pets),
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stylish header with icon
          Row(
            children: [
              Icon(Icons.hotel, color: AppColors.primary, size: 28),
              const SizedBox(width: 12),
              Text(
                'Room Features',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 36),

          // Room Features Section
          FeatureCategorySection(
            title: 'Room Amenities',
            categoryIcon: Icons.bedroom_parent,
            features: roomFeatures,
          ),

          // Dining Features Section
          FeatureCategorySection(
            title: 'Dining Options',
            categoryIcon: Icons.restaurant,
            features: diningFeatures,
          ),

          // Service Features Section
          FeatureCategorySection(
            title: 'Services & Facilities',
            categoryIcon: Icons.room_service,
            features: serviceFeatures,
          ),

          FeatureCategorySection(
            title: 'Policy',
            categoryIcon: Icons.policy,
            features: policy,
          ),
        ],
      ),
    );
  }
}

class FeatureItem {
  final String name;
  final bool isAvailable;
  final IconData icon;

  FeatureItem(this.name, this.isAvailable, this.icon);
}