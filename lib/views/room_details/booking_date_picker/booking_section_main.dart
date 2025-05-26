import 'package:flutter/material.dart';
import 'package:nest_user_app/views/room_details/booking_date_picker/date_card_section.dart';

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
            child: Column(children: [
              DateCardSection()
            ],
                ),
          ),
        ),
      ),
    );
  }
}
