import 'package:flutter/foundation.dart';

class PersonCountProvider extends ChangeNotifier {
  int _adultCount = 1; 
  int _childrenCount = 0;

  int get adultCount => _adultCount;
  int get childrenCount => _childrenCount;
  int get totalCount => _adultCount + _childrenCount;

  void incrementAdults() {
    _adultCount++;
    notifyListeners();
  }

  void decrementAdults() {
    if (_adultCount > 1) {
      _adultCount--;
      notifyListeners();
    }
  }

  void incrementChildren() {
    _childrenCount++;
    notifyListeners();
  }

  void decrementChildren() {
    if (_childrenCount > 0) {
      _childrenCount--;
      notifyListeners();
    }
  }

  void setAdultCount(int count) {
    if (count >= 1) {
      _adultCount = count;
      notifyListeners();
    }
  }

  void setChildrenCount(int count) {
    if (count >= 0) {
      _childrenCount = count;
      notifyListeners();
    }
  }

  void reset() {
    _adultCount = 1;
    _childrenCount = 0;
    notifyListeners();
  }

  // Calculate required number of rooms based on room capacity
  int calculateRequiredRooms({
    required int maxAdultsPerRoom,
    required int maxChildrenPerRoom,
  }) {
    if (maxAdultsPerRoom <= 0) return 1; // Safety check

    // Calculate rooms needed for adults
    int roomsForAdults = (_adultCount / maxAdultsPerRoom).ceil();

    // Calculate rooms needed for children (if any)
    int roomsForChildren = 0;
    if (_childrenCount > 0 && maxChildrenPerRoom > 0) {
      roomsForChildren = (_childrenCount / maxChildrenPerRoom).ceil();
    }

    // Return the maximum of both requirements
    return roomsForAdults > roomsForChildren
        ? roomsForAdults
        : roomsForChildren;
  }

  void clearPersonData() {
    reset(); 
  }
}
