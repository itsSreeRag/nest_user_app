import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class HomeSearchByCity extends StatelessWidget {
  const HomeSearchByCity({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CityModel> cityData = [
      CityModel(cityName: 'Near By', cityImages: 'assets/images/images_1.jpg'),
      CityModel(cityName: 'pune', cityImages: 'assets/images/images_1.jpg'),
      CityModel(cityName: 'Goa', cityImages: 'assets/images/images_1.jpg'),
      CityModel(cityName: 'Delhi', cityImages: 'assets/images/images_1.jpg'),
      CityModel(cityName: 'Kerala', cityImages: 'assets/images/images_1.jpg'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Explore By City',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
              ),
            ),

            Text(
              'View All',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cityData.length,
            itemBuilder: (context, index) {
              final city = cityData[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: AssetImage(city.cityImages),
                    ),
                  ),
                  Text(
                    city.cityName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black54,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class CityModel {
  final String cityImages;

  final String cityName;

  CityModel({required this.cityName, required this.cityImages});
}
