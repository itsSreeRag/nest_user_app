import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/controllers/review_rating_controller/review_rating_controller.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_text_field.dart';
import 'package:provider/provider.dart';

class ReviewRatingMain extends StatelessWidget {
  final String hotelId;
  const ReviewRatingMain({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final reviewRatingController = Provider.of<ReviewRatingProvider>(context);

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Review & Ratings',
          style: TextStyle(color: AppColors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
        
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How was the hotel?',
                  style: TextStyle(
                    color: AppColors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) =>
                          Icon(Icons.star, color: AppColors.secondary),
                  onRatingUpdate: (rating) {
                    reviewRatingController.rating = rating;
                  },
                ),
                SizedBox(height: 15),
                Text(
                  'Write A Review',
                  style: TextStyle(
                    color: AppColors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                MyCustomTextFormField(
                  controller: reviewController,
                  hintText: 'What should other customer know?',
                  validator:
                      (value) => MyAppValidators().validateNames(
                        value,
                        name: 'Add your review',
                      ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 10,
                  minLines: 10,
                ),
                SizedBox(height: 15),
                MyCustomTextFormField(
                  labelText: 'Title Your Review (required)',
                  controller: titleController,
                  hintText: 'What\'s most important to know?',
                  validator:
                      (value) => MyAppValidators().validateNames(
                        value,
                        name: 'Add your Review title',
                      ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 15),
                MyCustomTextFormField(
                  labelText: 'What,s Your public name? (required)',
                  controller: nameController,
                  hintText: 'What\'s most important to know?',
                  validator:
                      (value) => MyAppValidators().validateNames(
                        value,
                        name: 'Add your Review title',
                      ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MyCustomButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Provider.of<ReviewRatingProvider>(
                context,
                listen: false,
              ).submitReview(
                context: context,
                publicName: nameController.text,
                hotelId: hotelId,
                reviewTitle: titleController.text,
                review: reviewController.text,
              );
            }
          },
          text: 'submit',
          backgroundcolor: AppColors.secondary,
        ),
      ),
    );
  }
}
