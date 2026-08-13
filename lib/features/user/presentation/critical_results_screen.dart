import 'package:flutter/material.dart';
import '../../../data/models/disaster_record.dart';
import '../../../data/repositories/mock_repository.dart';

class CriticalResultsScreen extends StatelessWidget {
  const CriticalResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final results = MockRepository.getMockRecords().where((r) => r.type == RecordType.critical).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Critical Records'),
        backgroundColor: Colors.red[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Possible Critical Matches',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'For privacy and sensitivity, photographs of deceased or critical persons are never shown to the public. Please review the identifying details below.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ...results.map((record) => _buildCriticalCard(context, record)),
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'If you recognize any of these details, please contact the listed official immediately.',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCriticalCard(BuildContext context, DisasterRecord record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red[100]!, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Possible Match Found',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${(record.matchConfidence! * 100).toInt()}% Match',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 32),
            _buildDetailRow('Name', record.fullName),
            _buildDetailRow('Age', '${record.age}'),
            _buildDetailRow('Last Clothing', record.lastKnownClothing ?? 'Not recorded'),
            _buildDetailRow('Found At', record.camp),
            _buildDetailRow('Officer', record.officerName),
            _buildDetailRow('Contact', record.officerContact),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Please contact the listed official/camp to confirm identity.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
