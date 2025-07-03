import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/saved/saved_gridview.dart';

class SavedPageMain extends StatelessWidget {
  const SavedPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Your Saved Hotels',
          style: TextStyle(
            color: AppColors.black87,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

      ),
      body: Center(child: SavedHotelsGrid()),
    );
  }
}
