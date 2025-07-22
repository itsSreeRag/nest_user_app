import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nest_user_app/controllers/privacy_policy_provider/privacy_policy_provider.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrivacyPolicyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child:
            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Markdown(
                  data: provider.markdownData,
                  padding: EdgeInsets.all(16),
                  styleSheet: MarkdownStyleSheet(
                    h1: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    p: TextStyle(fontSize: 16),
                  ),
                ),
      ),
    );
  }
}
