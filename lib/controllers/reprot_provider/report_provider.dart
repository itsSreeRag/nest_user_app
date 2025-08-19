// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/report_model.dart';
import 'package:nest_user_app/services/report_service.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';

class ReportProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ReportServices reportServices = ReportServices();

  List<ReportModel> reports = [];

  List<ReportModel> _userReports = [];
  List<ReportModel> get userReports => _userReports;

  Future<void> submitReports({
    required BuildContext context,
    required String publicName,
    required String hotelId,
    required String reportTitle,
    required String report,
  }) async {
    try {
      final reportId = await reportServices.generateReviewId();

      final newReview = ReportModel(
        title: reportTitle,
        description: report,
        createdAt: DateTime.now(),
        hotelId: hotelId,
        userName: publicName,
        userId: _auth.currentUser!.uid,
        reportId: reportId,
      );

      await reportServices.reportSubmitFirebase(newReview, reportId);

      MyCustomSnackBar.show(
        context: context,
        title: 'Success',
        message: 'report submitted successfully!',
        backgroundColor: AppColors.green,
        accentColor: AppColors.white,
      );
    } catch (e) {
      MyCustomSnackBar.show(
        context: context,
        title: 'Error',
        message: 'Failed to submit reprot. Please try again.',
        backgroundColor: AppColors.red,
        accentColor: AppColors.white,
      );
    }
  }

  Future<void> fetchReports() async {
    try {
      final userId = _auth.currentUser!.uid;
      reports = await reportServices.fetchReportsByUserId();
      _userReports = reports.where((r) => r.userId == userId).toList();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
