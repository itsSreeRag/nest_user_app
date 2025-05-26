import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/hotel_models.dart';

class HotelDetailsImageSection extends StatelessWidget {
  const HotelDetailsImageSection({
    super.key,
    required this.hotelData,
  });

  final HotelModel hotelData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hotel Image
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.grey,
            image: DecorationImage(
              image: NetworkImage(hotelData.profileImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Top Navigation
        Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Interior/Exterior Toggle
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Interior',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: const Text(
                        'Exterior',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Action buttons
              Row(
                children: [
                  CircularButton(
                    icon: Icons.favorite,
                    color: AppColors.red,
                  ),
                  const SizedBox(width: 8),
                  CircularButton(
                    icon: Icons.share,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircularButton(
                      icon: Icons.close,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Hotel brand and price
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            // color: Colors.black.withOpacity(0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      hotelData.stayName,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: AppColors.secondary,
                          size: 20,
                        ),
                        Text(
                          ' 4.5/5',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //  Text(
                //   hotelData.,
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 32,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularButton({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            Colors.white, // Replace with AppColors.white if using custom theme
      ),
      child: Center(child: Icon(icon, color: color, size: 22)),
    );
  }
}