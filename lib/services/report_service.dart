import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanoid/async.dart';
import 'package:nest_user_app/models/report_model.dart';

class ReportServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> generateReviewId() async {
    return await nanoid(10);
  }

  Future<void> reportSubmitFirebase(ReportModel report, String reprotId) async {
    await _firestore.collection('reprot').doc(reprotId).set(report.toMap());
  }

  Future<List<ReportModel>> fetchReportsByUserId() async {
    try {
      final snapshot = await _firestore.collection('reprot').get();

      return snapshot.docs
          .map((doc) => ReportModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
