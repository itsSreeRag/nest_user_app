// utils/booking_utils.dart
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class BookingUtils {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return AppColors.green;
      case 'cancelled':
        return AppColors.red;
      case 'completed':
        return AppColors.green;
      default:
        return AppColors.grey;
    }
  }

  static Color getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'completed':
        return AppColors.green;
      case 'failed':
      case 'cancelled':
        return AppColors.red;
      default:
        return AppColors.grey;
    }
  }

  static String formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}