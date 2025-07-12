import 'package:flutter/widgets.dart';

class NavigationBarProvider extends ChangeNotifier {
  int currentIndex = 0;

 
  PageController pageController = PageController(initialPage: 0);

  void updateIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void disposeController() {
    pageController.dispose();
  }

  void clearNavidationBar(){
    currentIndex=0;
  }
}