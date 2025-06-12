// payment_handler.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/services/stripe_services.dart';

class PaymentHandler {
  static final PaymentHandler _instance = PaymentHandler._internal();
  factory PaymentHandler() => _instance;
  PaymentHandler._internal();

  /// Tests network connectivity before proceeding with payment
  Future<bool> testNetworkConnectivity() async {
    try {
      log('Testing network connectivity...');
      return await StripeServices.instance.testNetworkConnectivity();
    } catch (e) {
      log('Network test error: $e');
      return false;
    }
  }

  /// Shows a loading dialog during payment processing
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  /// Dismisses the loading dialog
  void _dismissLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  /// Shows error message to user
  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Processes payment with network check and error handling
  /// Returns true if payment is successful, false otherwise
  Future<bool> processPayment({
    required BuildContext context,
    required int amount,
  }) async {
    try {
      // Test network connectivity first
      _showLoadingDialog(context);
      
      bool networkOk = await testNetworkConnectivity();
      
      if (!networkOk) {
        _dismissLoadingDialog(context);
        log('Network connectivity issue');
        _showErrorMessage(context, 'No internet connection.');
        return false;
      }

      log('Network is working, proceeding with payment...');
      
      // Process the payment
      bool paymentSuccess = await StripeServices.instance.makePayment(amount);
      _dismissLoadingDialog(context);

      if (!paymentSuccess) {
        log('Payment failed');
        _showErrorMessage(context, 'Payment failed. Please try again.');
        return false;
      }

      log('Payment successful');
      return true;
      
    } catch (e) {
      _dismissLoadingDialog(context);
      log('Payment processing error: $e');
      _showErrorMessage(context, 'Payment failed. Please try again.');
      return false;
    }
  }

  /// Alternative method for just processing payment without UI handling
  /// (for cases where you want to handle UI separately)
  Future<bool> makePaymentOnly(int amount) async {
    try {
      return await StripeServices.instance.makePayment(amount);
    } catch (e) {
      log('Payment error: $e');
      return false;
    }
  }
}