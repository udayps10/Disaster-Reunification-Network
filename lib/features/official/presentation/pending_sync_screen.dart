import 'package:flutter/material.dart';

class PendingSyncScreen extends StatelessWidget {
  const PendingSyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Sync')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'The following records are waiting to be uploaded to the server.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildSyncItem('Record #102', 'Waiting for internet', Icons.wifi_off),
          _buildSyncItem('Record #103', 'Waiting to upload photo', Icons.image),
          _buildSyncItem('Record #104', 'Synced', Icons.check_circle, isSynced: true),
        ],
      ),
    );
  }

  Widget _buildSyncItem(String title, String status, IconData icon, {bool isSynced = false}) {
    return ListTile(
      leading: Icon(icon, color: isSynced ? Colors.green : Colors.orange),
      title: Text(title),
      subtitle: Text(status),
      trailing: isSynced ? null : const Icon(Icons.sync),
    );
  }
}
