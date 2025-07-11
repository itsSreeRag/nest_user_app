import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/user_provider/user_provider.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/profile_details_edit_main.dart';
import 'package:nest_user_app/views/profile/profile_details.dart/widgets/user_profile_card.dart';
import 'package:provider/provider.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<UserProvider>(listen: false, context);
    return FutureBuilder(
      future: profileProvider.fetchUser(),
      builder: (context, asyncSnapshot) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final userData = userProvider.currentUser;

            if (userProvider.isLoading) {
              return SizedBox(
                width: double.infinity,
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (userData == null) {
              return const Center(child: Text("No user found."));
            }

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailsMain()),
                );
              },
              child: UserProfileCard(userData: userData),
            );
          },
        );
      },
    );
  }
}
