import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/room_details/room_features_section/room_detail_feature_section.dart';
import 'package:nest_user_app/views/room_details/room_features_section/room_feature_card.dart';

class FeatureCategorySection extends StatelessWidget {
  final String title;
  final IconData categoryIcon;
  final List<FeatureItem> features;

  const FeatureCategorySection({
    super.key,
    required this.title,
    required this.categoryIcon,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(categoryIcon, color: AppColors.primary, size: 22),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return FeatureCard(
              feature: feature.name,
              isAvailable: feature.isAvailable,
              customIcon: feature.icon,
              activeColor: AppColors.green,
            );
          },
        ),
      ],
    );
  }
}
