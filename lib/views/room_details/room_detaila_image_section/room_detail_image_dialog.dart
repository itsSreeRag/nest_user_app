import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/room_provider/room_detail_image_provider.dart';
import 'package:provider/provider.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoomDetailImageProvider>(context);
    final roomImages = provider.roomImages;

    if (roomImages.isEmpty) {
      return const Center(child: Text("No images available"));
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Image ${provider.currentIndex + 1} of ${roomImages.length}',
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.black,
              child: PageView.builder(
                controller: provider.pageController,
                itemCount: roomImages.length,
                onPageChanged: provider.updateIndex,
                itemBuilder:
                    (_, index) => InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 3,
                      child: Image.network(
                        roomImages[index],
                        fit: BoxFit.contain,
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(Icons.error, color: Colors.white),
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (provider.currentIndex > 0)
                ElevatedButton(
                  onPressed: provider.previousPage,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              const SizedBox(width: 24),
              if (provider.currentIndex < roomImages.length - 1)
                ElevatedButton(
                  onPressed: provider.nextPage,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
            ],
          ),
        ],
      ),
    );
  }
}