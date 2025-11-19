import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/widgets/my_button.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final String? buttonLeft;
  final String? buttonRight;
  final String subTitle;
  final String lottieFile;
  // final Icon icon;
  final VoidCallback buttonLeftOnTap;
  final VoidCallback buttonRightOnTap;
  const CustomShowDialog({
    super.key,
    required this.title,
    this.buttonLeft,
    this.buttonRight,
    required this.subTitle,
    // required this.icon,
    required this.buttonLeftOnTap,
    required this.buttonRightOnTap,
    this.lottieFile = 'assets/animations/Connection error.json',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Lottie.asset(
              lottieFile,
              // width: 100,
              // height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        subTitle,
        style: TextStyle(color: AppColors.black54),
        textAlign: TextAlign.center,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyCustomButton(
                    width: 100,
                    backgroundcolor: AppColors.grey,
                    onPressed: buttonLeftOnTap,
                    text: buttonLeft ?? 'Cancel',
                  ),
                  MyCustomButton(
                    width: 100,
                    backgroundcolor: AppColors.red,
                    onPressed: buttonRightOnTap,
                    text: buttonRight ?? 'Confirm',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
