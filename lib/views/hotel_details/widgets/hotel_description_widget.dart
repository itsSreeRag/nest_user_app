import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:readmore/readmore.dart';

class HotelDescriptionWidget extends StatelessWidget {
  final String description;

  const HotelDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.withAlpha(10)),
      ),
      child: ReadMoreText(
        description,
        trimLines: 3,
        colorClickableText: AppColors.primary,
        trimMode: TrimMode.Line,
        trimCollapsedText: '...See more',
        trimExpandedText: ' See less',
        style:  TextStyle(
          fontSize: 16,
          height: 1.5,
          color: AppColors.black87,
        ),
        moreStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        lessStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}