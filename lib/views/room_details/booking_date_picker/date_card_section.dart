import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/widgets/date_range_picker.dart';
import 'package:provider/provider.dart';

class DateCardSection extends StatelessWidget {
  const DateCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRange = context.watch<DateRangeProvider>().selectedDateRange;
    final startdate = selectedRange?.start;
    final enddate = selectedRange?.end;

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
              'Select Dates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            const DateRangePickerWidget(),
            const SizedBox(height: 16),
            if (startdate != null && enddate != null)
              Text(
                'Start: ${DateFormat('dd MMM yyyy').format(startdate)}\nEnd: ${DateFormat('dd MMM yyyy').format(enddate)}',
                style: TextStyle(fontSize: 14, color: AppColors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
