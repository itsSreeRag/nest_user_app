import 'package:flutter/material.dart';

class RoomDetailImageProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController? pageController;
  List<String> roomImages = [];

  void setInitialData({required int index, required List<String> images}) {
    currentIndex = index;
    roomImages = images;
    pageController = PageController(initialPage: index);
    notifyListeners();
  }

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (pageController != null && currentIndex < roomImages.length - 1) {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (pageController != null && currentIndex > 0) {
      pageController!.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }
}
