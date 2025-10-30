import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/gemini_provider/gemini_provider.dart';
import 'package:nest_user_app/views/near_attraction_page/widget/attraction_card.dart';
import 'package:provider/provider.dart';

class NearbyAttractionsPage extends StatelessWidget {
  final String location;
  const NearbyAttractionsPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.watch<GeminiProvider>();
    final data = geminiProvider.attractions;
    final lines = data.split('\n').where((e) => e.trim().isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.background,
                  AppColors.background.withAlpha((0.8 * 255).toInt()),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.place_rounded,
                      color: AppColors.blue400,
                      size: 28,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Nearby Attractions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.blue50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.blue400, width: 1),
                  ),
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final line = lines[index];
                final match = RegExp(
                  r'^\d+\.\s*(.+?)\s*-\s*(.+)$',
                ).firstMatch(line.trim());

                String title;
                String description;
                if (match != null) {
                  title = match.group(1)?.trim() ?? '';
                  description = match.group(2)?.trim() ?? '';
                } else {
                  final parts = line.split('-');
                  title =
                      parts.first.replaceAll(RegExp(r'^\d+\.\s*'), '').trim();
                  description =
                      parts.length > 1 ? parts.sublist(1).join('-').trim() : '';
                }
                return AttractionCard(
                  index: index,
                  title: title,
                  description: description,
                );
              },
              itemCount: lines.length,
            ),
          ),
        ],
      ),
    );
  }
}
