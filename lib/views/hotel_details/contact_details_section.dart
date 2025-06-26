import 'package:flutter/material.dart';
import 'package:nest_user_app/views/hotel_details/widgets/contact_card.dart';
import 'package:nest_user_app/views/hotel_details/widgets/section_heder_widget.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String phoneNumber;
  final String email;

  const ContactDetailsWidget({
    super.key,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderWidget(
            title: 'Contact Details',
            icon: Icons.contact_phone_outlined,
          ),
          const SizedBox(height: 16),
          ContactCard(icon: Icons.phone, title: 'Phone', value: phoneNumber),
          ContactCard(icon: Icons.email_outlined, title: 'Email', value: email),
        ],
      ),
    );
  }
}
