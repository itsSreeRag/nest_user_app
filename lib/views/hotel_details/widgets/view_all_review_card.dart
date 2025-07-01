import 'package:flutter/material.dart';
import 'package:nest_user_app/views/hotel_details/widgets/review_show_card.dart';
import 'package:nest_user_app/views/hotel_details/widgets/total_rating_card.dart';

class ViewAllReviewCard extends StatelessWidget {
  const ViewAllReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          TotalRatingCard(),
      
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ReviewShowCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}