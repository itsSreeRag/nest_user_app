import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nest_user_app/views/booking/booking_card/widgets/booking_card_date_column.dart';

class DateSection extends StatelessWidget {
  final DateTime checkIn;
  final DateTime checkOut;

  const DateSection({
    super.key,
    required this.checkIn,
    required this.checkOut,
  });

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DateColumn(
            label: 'Check-in',
            date: formatDate(checkIn),
          ),
        ),
        Expanded(
          child: DateColumn(
            label: 'Check-out',
            date: formatDate(checkOut),
          ),
        ),
      ],
    );
  }
}


