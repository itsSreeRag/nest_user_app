import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nest_user_app/services/stripe_services.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/date_card_section.dart';
import 'package:nest_user_app/widgets/my_button.dart';

class BookingSectionMain extends StatelessWidget {
  const BookingSectionMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Book Now')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [DateCardSection()]),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyCustomButton(
          onPressed: () async {
  log('Testing network...');
  bool networkOk = await StripeServices.instance.testNetworkConnectivity();
  if (networkOk) {
    log('Network is working, proceeding with payment...');
    await StripeServices.instance.makePayment();
  } else {
    log('Network connectivity issue');
  }
},
          text: 'Next',
        ),
      ),
    );
  }
}
