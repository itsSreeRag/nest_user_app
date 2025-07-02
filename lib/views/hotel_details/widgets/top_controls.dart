import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/favorite_provider/favorite_provider.dart';

class TopControls extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final bool isFav;
  final String hotelId;

  const TopControls({
    super.key,
    required this.fadeAnimation,
    required this.isFav,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.black.withAlpha((0.4 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.white.withAlpha((0.2 * 255).toInt()),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: GestureDetector(
              onTap: () {
                context.read<FavoriteProvider>().toggleFavorite(hotelId,context);
                HapticFeedback.lightImpact();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isFav
                          ? AppColors.red.withAlpha((0.9 * 255).toInt())
                          : AppColors.black.withAlpha((0.4 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isFav
                            ? AppColors.red.withAlpha((0.3 * 255).toInt())
                            : AppColors.white.withAlpha((0.2 * 255).toInt()),
                    width: 1,
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.white,
                    size: 20,
                    key: ValueKey(isFav),
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
