// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/gemini_provider/gemini_provider.dart';
import 'package:nest_user_app/views/near_attraction_page/nearby_attraction_page.dart';
import 'package:provider/provider.dart';

class DiscoverButton extends StatelessWidget {
  final String city;
  const DiscoverButton({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.watch<GeminiProvider>();

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blue600, AppColors.blue400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withAlpha((0.3 * 255).toInt()),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap:
              geminiProvider.isLoading
                  ? null
                  : () async {
                    final success = await geminiProvider.fetchNearbyAttractions(
                      location: city,
                    );

                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NearbyAttractionsPage(location: city),
                        ),
                      );
                    } else if (geminiProvider.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(geminiProvider.errorMessage!),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child:
                geminiProvider.isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          'Discover Nearby Attractions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
