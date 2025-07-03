import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/profile_provider/user_provider.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/profile_details_main.dart';
import 'package:provider/provider.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userData = userProvider.currentUser;

        if (userProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userData == null) {
          return const Center(child: Text("No user found."));
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDetailsMain(),
              ),
            );
          },
          child: Container(
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
                          : const AssetImage('assets/images/images_1.jpg')
                              as ImageProvider,
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
          ),
        );
      },
    );
  }
}
