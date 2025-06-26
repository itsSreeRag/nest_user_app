import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/room_model.dart';

class RoomDetailImage extends StatelessWidget {
  final RoomModel roomData;
  const RoomDetailImage({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    List images = roomData.roomImages;
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 0.5,
                autoPlayInterval: Duration(seconds: 20),
                viewportFraction: 1,
              ),
              items:
                  images.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: double.infinity,
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                            imageUrl: imagePath,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
          ),

          Positioned(
            left: 10,
            top: 50,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withAlpha((0.2 * 255).toInt()),
                  border: Border.all(
                    color: AppColors.white.withAlpha((0.3 * 255).toInt()),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withAlpha((0.1 * 255).toInt()),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
