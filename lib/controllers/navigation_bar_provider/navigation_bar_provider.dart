import 'package:flutter/widgets.dart';

class NavigationBarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  PageController pageController = PageController(initialPage: 0);

  void updateIndex(int index) {
    _currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void disposeController() {
    pageController.dispose();
  }
}