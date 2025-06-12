import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/navigation_bar_provider/navigation_bar_provider.dart';
import 'package:nest_user_app/views/booking/booking_main.dart';
import 'package:nest_user_app/views/home_screen/home_page_main.dart';
import 'package:nest_user_app/views/profile/account_page_main.dart';
import 'package:nest_user_app/views/saved/saved_page_main.dart';
import 'package:provider/provider.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationBarProvider>(context);
    final pages = [
      HomeScreenMain(),
      BookingPageMain(),
      SavedPageMain(),
      AccountPageMain(),
    ];

    return Scaffold(
      body: PageView(
        controller: provider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: NotchBottomBarController(
          index: provider.currentIndex,
        ),
        color: AppColors.primary,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        shadowElevation: 5,
        maxLine: 1,
        notchColor: AppColors.black,
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 500,
        blurOpacity: 15,

        itemLabelStyle: TextStyle(
          fontSize: 13,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_outlined, color: AppColors.white),
            activeItem: Icon(Icons.home, color: AppColors.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.book_online_outlined,
              color: AppColors.white,
            ),
            activeItem: Icon(Icons.book_online, color: AppColors.white),
            itemLabel: 'Booked',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.favorite_outline, color: AppColors.white),
            activeItem: Icon(Icons.favorite, color: AppColors.white),
            itemLabel: 'Saved',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person_outline, color: AppColors.white),
            activeItem: Icon(Icons.person, color: AppColors.white),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) => provider.updateIndex(index),
        kIconSize: 24.0,
        kBottomRadius: 28.0,
      ),
    );
  }
}
