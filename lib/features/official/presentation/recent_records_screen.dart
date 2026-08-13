import 'package:flutter/material.dart';
import '../../../data/repositories/mock_repository.dart';

class RecentRecordsScreen extends StatelessWidget {
  const RecentRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = MockRepository.getMockRecords();

    return Scaffold(
      appBar: AppBar(title: const Text('Recent Records')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.orange[50],
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.orange),
                SizedBox(width: 8),
                Text('Showing recently cached records (Offline Mode)', style: TextStyle(fontSize: 12, color: Colors.orange)),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: records.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final r = records[index];
                return ListTile(
                  title: Text(r.fullName),
                  subtitle: Text('Found at ${r.camp}'),
                  trailing: Text(
                    '${r.dateTimeFound.day}/${r.dateTimeFound.month}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
