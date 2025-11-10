import 'package:flutter/material.dart';

class SignInPageText extends StatelessWidget {
  const SignInPageText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Book your next stay with ease.',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
    );
  }
}