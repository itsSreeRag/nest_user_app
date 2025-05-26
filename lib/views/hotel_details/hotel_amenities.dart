import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/hotel_models.dart';

class HotelAmenities extends StatelessWidget {
  final HotelModel hotelData;
  const HotelAmenities({super.key, required this.hotelData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is this place offers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HotelAmenitiesCard(
                  icon: Icons.cancel,
                  label: 'Free Cancellation',
                  cardStatus: hotelData.freeCancellation,
                ),
                HotelAmenitiesCard(
                  icon: Icons.local_parking_rounded,
                  label: 'Parking',
                  cardStatus: hotelData.parking,
                ),
                HotelAmenitiesCard(
                  icon: Icons.home,
                  label: 'Entire Property',
                  cardStatus: hotelData.entireProperty,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HotelAmenitiesCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool cardStatus;
  const HotelAmenitiesCard({
    super.key,
    required this.icon,
    required this.label,
    required this.cardStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: cardStatus ? AppColors.green : AppColors.red,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 30,
              color: cardStatus ? AppColors.green : AppColors.red,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

