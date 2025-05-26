import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/room_provider/room_detail_image_provider.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/views/room_details/room_detaila_image_section/room_detail_image_dialog.dart';
import 'package:provider/provider.dart';

class RoomDetailListImages extends StatelessWidget {
  const RoomDetailListImages({super.key, required this.roomData});

  final RoomModel roomData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roomData.roomImages.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                final provider = Provider.of<RoomDetailImageProvider>(
                  context,
                  listen: false,
                );
                provider.setInitialData(
                  index: index,
                  images: roomData.roomImages,
                );

                showDialog(
                  context: context,
                  builder: (_) => const ImageDialog(),
                );
              },

              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.grey300, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.network(
                    roomData.roomImages[index],
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: AppColors.grey300,
                          child: Icon(
                            Icons.broken_image,
                            color: AppColors.grey,
                          ),
                        ),
                    loadingBuilder:
                        (context, child, progress) =>
                            progress == null
                                ? child
                                : Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        progress.expectedTotalBytes != null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                    color: AppColors.primary,
                                  ),
                                ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
