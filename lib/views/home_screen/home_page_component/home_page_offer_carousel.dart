import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeOfferCarousel extends StatelessWidget {
  const HomeOfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/images/images_1.jpg',
      'assets/images/images_1.jpg',
      'assets/images/images_1.jpg',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        const Text(
          'Best Offer For You',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 2.2,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 1,
          ),
          items:
              imagePaths.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}
