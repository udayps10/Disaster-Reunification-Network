import 'package:flutter/material.dart';
import '../../../data/models/disaster_record.dart';
import '../../../data/repositories/mock_repository.dart';
import '../../../core/common_widgets/app_button.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final results = MockRepository.getMockRecords().where((r) => r.type == RecordType.normal).toList();
    final top3 = results.take(3).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Possible Matches')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Based on the details you provided',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...top3.map((record) => _buildRecordCard(context, record)),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              "Didn't find your person?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'View More Matches',
              onPressed: () {
                // In a real app, this would fetch/show more.
                // For mock, we'll just show a snackbar or more cards below.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Showing additional probable matches.')),
                );
              },
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Still haven\'t found your person?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Some people may be listed in critical records. Their photographs are never shown here. We only display identifying information that may help you recognize them.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Search Critical Records',
                    color: Colors.red,
                    onPressed: () => Navigator.pushNamed(context, '/critical_results'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(BuildContext context, DisasterRecord record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                record.photoUrl ?? 'https://via.placeholder.com/80',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        record.fullName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${(record.matchConfidence! * 100).toInt()}% Match',
                          style: TextStyle(color: Colors.green[800], fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Text('Age: ${record.age}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text('Location: ${record.camp}', style: const TextStyle(fontSize: 12)),
                  Text('Status: ${record.status.name.toUpperCase()}', 
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
