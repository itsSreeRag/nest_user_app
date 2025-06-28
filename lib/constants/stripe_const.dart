import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeKeys {
  static final String publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  static final String secretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? '';
}
