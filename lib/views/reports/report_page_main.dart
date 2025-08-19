import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/controllers/reprot_provider/report_provider.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_text_field.dart';
import 'package:provider/provider.dart';

class ReportPageMain extends StatelessWidget {
  final String hotelId;
  const ReportPageMain({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reportDescription = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Hotel',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Write A report',
                  style: TextStyle(
                    color: AppColors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                MyCustomTextFormField(
                  controller: reportDescription,
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
                  labelText: 'Title Your report (required)',
                  controller: titleController,
                  hintText: 'What\'s most important to know?',
                  validator:
                      (value) => MyAppValidators().validateNames(
                        value,
                        name: 'Add your report title',
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
        padding: const EdgeInsets.all(16.0),
        child: MyCustomButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await Provider.of<ReportProvider>(
                context,
                listen: false,
              ).submitReports(
                context: context,
                publicName: nameController.text,
                hotelId: hotelId,
                reportTitle: titleController.text,
                report: reportDescription.text,
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
          text: 'Report',
          backgroundcolor: AppColors.red,
        ),
      ),
    );
  }
}
