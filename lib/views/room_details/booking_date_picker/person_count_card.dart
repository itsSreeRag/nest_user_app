import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
import 'package:provider/provider.dart';

class PersonCountCardSection extends StatelessWidget {
  const PersonCountCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Persons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            const PersonCountSelector(),
            const SizedBox(height: 16),
            Consumer<PersonCountProvider>(
              builder: (context, provider, child) {
                return Text(
                  'Adults: ${provider.adultCount}\nChildren: ${provider.childrenCount}',
                  style: TextStyle(fontSize: 14, color: AppColors.grey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PersonCountSelector extends StatelessWidget {
  const PersonCountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonCountProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // Adults Counter
            _buildCounterRow(
              context,
              'Adults',
              provider.adultCount,
              () => provider.incrementAdults(),
              () => provider.decrementAdults(),
            ),
            const SizedBox(height: 12),
            // Children Counter
            _buildCounterRow(
              context,
              'Children',
              provider.childrenCount,
              () => provider.incrementChildren(),
              () => provider.decrementChildren(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCounterRow(
    BuildContext context,
    String label,
    int count,
    VoidCallback onIncrement,
    VoidCallback onDecrement,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            _buildCounterButton(
              icon: Icons.remove,
              onPressed: count > 0 ? onDecrement : null,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildCounterButton(
              icon: Icons.add,
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: onPressed != null ? AppColors.primary : AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: onPressed != null ? AppColors.white : AppColors.grey,
          size: 20,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}