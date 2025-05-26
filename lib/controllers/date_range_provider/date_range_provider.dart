import 'package:flutter/material.dart';

class DateRangeProvider extends ChangeNotifier {
  DateTimeRange? _selectedDateRange;

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  void setDateRange(DateTimeRange range) {
    _selectedDateRange = range;
    notifyListeners();
  }
}
