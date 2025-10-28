import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/user_model.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key, required this.userData});

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;


    double textScale = width / 390; 
    double avatarRadius = width * 0.14;
    double padding = width * 0.05; 

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage:
                (userData.profileImage != null &&
                        userData.profileImage!.startsWith("http"))
                    ? NetworkImage(userData.profileImage!) as ImageProvider
                    : const AssetImage('assets/images/images_1.jpg'),
          ),

          SizedBox(width: width * 0.04),

          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  userData.name ?? "User Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22 * textScale,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black87,
                  ),
                ),

                SizedBox(height: height * 0.005),

                // Phone Number
                if (userData.phoneNumber != null &&
                    userData.phoneNumber!.isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.phone,
                          size: 14 * textScale, color: AppColors.grey600),
                      SizedBox(width: width * 0.012),
                      Flexible(
                        child: Text(
                          userData.phoneNumber!,
                          style: TextStyle(
                            color: AppColors.grey600,
                            fontSize: 14 * textScale,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: height * 0.005),

                // Email
                if (userData.email != null && userData.email!.isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.email,
                          size: 14 * textScale, color: AppColors.grey600),
                      SizedBox(width: width * 0.012),
                      Flexible(
                        child: Text(
                          userData.email!,
                          style: TextStyle(
                            color: AppColors.grey600,
                            fontSize: 14 * textScale,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: height * 0.008),

                // Edit button
                GestureDetector(
                  onTap: () {
                   
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit,
                          size: 18 * textScale, color: AppColors.blue700),
                      SizedBox(width: width * 0.012),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: AppColors.blue700,
                          fontSize: 17 * textScale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
