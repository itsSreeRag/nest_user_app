import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/location_provider/location_provider.dart';
import 'package:provider/provider.dart';

class HomeLocationDetails extends StatelessWidget {
  const HomeLocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return InkWell(
          onTap: () async {
            await locationProvider.fetchCurrentLocation();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Location',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 4),
                  locationProvider.isLoading
                      ? Row(
                        children: const [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Fetching location...",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                      : locationProvider.errorMessage != null ||
                          (locationProvider.city?.isEmpty ?? true)
                      ? Row(
                        children: [
                          const Icon(
                            Icons.location_off,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Click here to fetch location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.secondary,
                            size: 22,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${locationProvider.city}, ${locationProvider.state}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                  SizedBox(height: 10),
                ],
              ),
              const Icon(
                Icons.notifications,
                color: AppColors.secondary,
                size: 25,
              ),
            ],
          ),
        );
      },
    );
  }
}
