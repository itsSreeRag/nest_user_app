import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/home_screen/home_page_component/home_page_search_city.dart';

class SearchCityCard extends StatelessWidget {
  const SearchCityCard({
    super.key,
    required this.city,
  });

  final CityModel city;

  @override
  Widget build(BuildContext context) {
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
  }
}