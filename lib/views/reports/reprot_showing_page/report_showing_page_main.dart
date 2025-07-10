import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/reprot_provider/report_provider.dart';
import 'package:provider/provider.dart';

class ReportShowingPageMain extends StatelessWidget {
  const ReportShowingPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reports'),
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder(
        future:
            Provider.of<ReportProvider>(context, listen: false).fetchReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer<ReportProvider>(
            builder: (context, reportProvider, _) {
              final reports = reportProvider.userReports;

              if (reports.isEmpty) {
                return const Center(child: Text('No reports submitted.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return ReportCard(
                    title: report.title,
                    description: report.description,
                    status: report.status,
                    date: report.createdAt.toLocal().toString().split(' ')[0],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String date;

  const ReportCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'in progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.report, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    border: Border.all(color: _getStatusColor(status)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            Text(
              'Date: $date',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
