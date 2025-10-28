import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/favorite_provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class HotelCard2 extends StatelessWidget {
  final String imagePath;
  final String hotelName;
  final String location;
  final double rating;
  final String price;
  final String hotelId;
  final bool isFavorite;
  final List<String> amenities;

  const HotelCard2({
    super.key,
    required this.imagePath,
    required this.hotelName,
    required this.location,
    required this.rating,
    required this.price,
    this.isFavorite = false,
    this.amenities = const ['WiFi', 'Parking', 'Breakfast'],
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Scale factors based on screen width
    double textScale = width / 390; // 390 is base iPhone 12 width
    double imageWidth = width * 0.35;
    double imageHeight = height * 0.18;

    return Container(
      width: double.infinity,
      height: height * 0.20,
      margin: EdgeInsets.only(bottom: height * 0.012),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.grey300),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          children: [
            // Hotel image
            Stack(
              children: [
                SizedBox(
                  width: imageWidth,
                  height: imageHeight,
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // Hotel details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hotel name
                    Text(
                      hotelName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18 * textScale,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: AppColors.primary,
                          size: 14 * textScale,
                        ),
                        SizedBox(width: 4 * textScale),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.grey600,
                              fontSize: 13 * textScale,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Amenities
                    Row(
                      children: amenities.take(3).map(
                        (amenity) {
                          return Container(
                            margin: EdgeInsets.only(right: 6 * textScale),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8 * textScale,
                              vertical: 4 * textScale,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(95),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              amenity,
                              style: TextStyle(
                                fontSize: 11 * textScale,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),

                    // Price & Favorite button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹$price',
                                style: TextStyle(
                                  color: Colors.teal.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18 * textScale,
                                ),
                              ),
                              TextSpan(
                                text: '/night',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13 * textScale,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Favorite button
                        Consumer<FavoriteProvider>(
                          builder: (context, favoriteProvider, _) {
                            final isFav = favoriteProvider.isFavorite(hotelId);
                            return InkWell(
                              onTap: () {
                                favoriteProvider.toggleFavorite(hotelId, context);
                              },
                              child: Container(
                                width: width * 0.09,
                                height: width * 0.09,
                                decoration: BoxDecoration(
                                  color: isFav
                                      ? AppColors.red.withAlpha(50)
                                      : AppColors.grey.withAlpha(50),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_outline_rounded,
                                  color: isFav
                                      ? Colors.red
                                      : Colors.grey.shade600,
                                  size: 20 * textScale,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
