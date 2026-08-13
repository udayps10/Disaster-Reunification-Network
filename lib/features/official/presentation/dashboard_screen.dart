import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';

class OfficialDashboardScreen extends StatelessWidget {
  const OfficialDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.officialDashboard),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 32),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildActionCard(context, Icons.person_add, 'Add Normal Person', '/add_normal'),
                _buildActionCard(context, Icons.warning_amber, 'Add Critical Record', '/add_critical', color: AppTheme.accentColor),
                _buildActionCard(context, Icons.search, 'Search Records', '/official_search'),
                _buildActionCard(context, Icons.history, 'Recent Records', '/recent_records'),
                _buildActionCard(context, Icons.sync_problem, 'Pending Sync', '/pending_sync'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem('Online', Icons.wifi, Colors.green),
          _buildStatusItem('0 Pending', Icons.cloud_upload, Colors.grey),
          _buildStatusItem('12 Records', Icons.description, AppTheme.primaryColor),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String label, String route, {Color? color}) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color ?? AppTheme.primaryColor),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
