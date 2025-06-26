import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/app_constance.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/explore_by_city/explore_by_city.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/search_city_card.dart';

class HomeSearchByCity extends StatelessWidget {
  const HomeSearchByCity({super.key});

  @override
  Widget build(BuildContext context) {
    final Appconstance appconstance = Appconstance();

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
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: appconstance.cityData.length,
            itemBuilder: (context, index) {
              final city = appconstance.cityData[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ExploreByCityMain(city: city.cityName),
                    ),
                  );
                },
                child: SearchCityCard(city: city),
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
