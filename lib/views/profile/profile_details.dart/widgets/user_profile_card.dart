import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/user_model.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key, required this.userData});

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage:
                (userData.profileImage != null &&
                        userData.profileImage!.startsWith("http"))
                    ? NetworkImage(userData.profileImage!)
                    : const AssetImage('assets/images/images_1.jpg'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData.name!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (userData.phoneNumber!.isNotEmpty)
                    Icon(Icons.phone, size: 14, color: AppColors.grey600),
                  const SizedBox(width: 5),
                  Text(
                    userData.phoneNumber!,
                    style: TextStyle(
                      color: AppColors.grey600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (userData.email!.isNotEmpty)
                    Icon(Icons.email, size: 14, color: AppColors.grey600),
                  const SizedBox(width: 5),
                  Text(
                    userData.email!,
                    style: TextStyle(
                      color: AppColors.grey600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Add navigation to Edit Profile screen here
                },
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 18, color: AppColors.blue700),
                    const SizedBox(width: 5),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.blue700,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
