import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nest_user_app/constants/stripe_const.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  // Add this method to test network connectivity
  Future<bool> testNetworkConnectivity() async {
    try {
      final Dio dio = Dio();
      // Test with a simple GET request first
      var response = await dio.get(
        "https://httpbin.org/get",
        options: Options(
          receiveTimeout: Duration(seconds: 10),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> makePayment() async {
    try {
      // Test network connectivity first
      bool networkAvailable = await testNetworkConnectivity();
      if (!networkAvailable) {
        return;
      }

      String? paymentIntentClientSecret = await _createPaymentIntent(10, "usd");

      if (paymentIntentClientSecret == null) {
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Nest booking App',
        ),
      );
      await processPayment();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();

      // Configure Dio with timeout settings
      dio.options = BaseOptions(
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
        sendTimeout: Duration(seconds: 15),
      );

      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };


      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.data != null) {
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      log("Error creating payment intent: $e");

      // More detailed error handling
      if (e is DioException) {
        log("DioException type: ${e.type}");
        log("DioException message: ${e.message}");
        if (e.response != null) {
          log("Response status: ${e.response?.statusCode}");
          log("Response data: ${e.response?.data}");
        }
      }
      return null;
    }
  }

  Future<void> processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      log("Payment completed successfully");
    } catch (e) {
      log("Error processing payment: $e");
      if (e is StripeException) {
        log("Stripe error: ${e.error.localizedMessage}");
      }
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
