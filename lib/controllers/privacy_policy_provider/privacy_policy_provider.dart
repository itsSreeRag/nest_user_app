import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrivacyPolicyProvider with ChangeNotifier {
  String markdownData = '';
  String tremsMarkdownData = '';
  bool isLoading = true;

  Future<void> loadPrivacyAndTerms() async {
    loadPrivacyPolicy();
    loadtermsAndCondition();
  }

  Future<void> loadPrivacyPolicy() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/privacy_policy.md',
      );
      markdownData = data;
    } catch (e) {
      markdownData = 'Failed to load privacy policy.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadtermsAndCondition() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/terms_and_conditions.md',
      );
      tremsMarkdownData = data;
    } catch (e) {
      tremsMarkdownData = 'Failed to load Terms and conditions';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
