import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';

import 'package:provider/provider.dart';

class DateRangePickerWidget extends StatelessWidget {
  const DateRangePickerWidget({super.key});

  Future<void> selectDateRange(BuildContext context) async {
    final provider = Provider.of<DateRangeProvider>(context, listen: false);

    final DateTime now = DateTime.now();
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange:
          provider.selectedDateRange ??
          DateTimeRange(start: now, end: now.add(const Duration(days: 1))),
      firstDate: now, // restrict to today or later
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.secondary,
              primary: AppColors.primary,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            appBarTheme:  AppBarTheme(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      provider.setDateRange(pickedDateRange);
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateRange =
        Provider.of<DateRangeProvider>(context).selectedDateRange;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppColors.black,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Select Date Range',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  selectedDateRange == null
                      ? AppColors.grey
                      : AppColors.green.withAlpha(82),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              selectedDateRange == null
                  ? "No date range selected"
                  : "Selected: ${formatDate(selectedDateRange.start)} - ${formatDate(selectedDateRange.end)}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    selectedDateRange == null
                        ? AppColors.grey600
                        :AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => selectDateRange(context),
            icon: const Icon(Icons.calendar_month),
            label: const Text('Choose Dates'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
            ),
          ),
        ],
      ),
    );
  }
}
