import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:provider/provider.dart';

void showLogoutDialog(BuildContext context) {
  final authProvider = Provider.of<MyAuthProviders>(context, listen: false);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              authProvider.logout(context);
              // Navigator.of(context).pop();
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}
