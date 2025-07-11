import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/image_provider/image_provider.dart';

import 'package:provider/provider.dart';


class AddRoomImageBottomSheet extends StatelessWidget {
  const AddRoomImageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<AddImageProvider>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColors.white,
      ),
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Choose Profile Photo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await imageProvider.pickImageFromCamera();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.camera, size: 70.0),
                    ),
                    const Text('CAMERA'),
                  ],
                ),
              ),
              const SizedBox(width: 70),
              SizedBox(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await imageProvider.pickImageFromGallery();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.photo, size: 70.0),
                    ),
                    const Text('GALLERY'),
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
