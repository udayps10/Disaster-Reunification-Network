import 'package:flutter/material.dart';
import '../../../data/models/disaster_record.dart';
import '../../../data/repositories/mock_repository.dart';

class SearchRecordsScreen extends StatefulWidget {
  const SearchRecordsScreen({super.key});

  @override
  State<SearchRecordsScreen> createState() => _SearchRecordsScreenState();
}

class _SearchRecordsScreenState extends State<SearchRecordsScreen> {
  final List<DisasterRecord> _allRecords = MockRepository.getMockRecords();
  List<DisasterRecord> _filteredRecords = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRecords = _allRecords;
  }

  void _filterRecords(String query) {
    setState(() {
      _filteredRecords = _allRecords
          .where((r) => r.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Records')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterRecords,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterRecords('');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRecords.length,
              itemBuilder: (context, index) {
                final record = _filteredRecords[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(record.photoUrl ?? 'https://via.placeholder.com/50'),
                    backgroundColor: record.type == RecordType.critical ? Colors.red : null,
                  ),
                  title: Text(record.fullName),
                  subtitle: Text('Age: ${record.age} | ${record.type.name.toUpperCase()}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showDetails(record),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(DisasterRecord record) {
    // Show a basic detail dialog or navigate to a details screen
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(record.photoUrl ?? 'https://via.placeholder.com/200'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(record.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (record.type == RecordType.critical)
                const Chip(label: Text('CRITICAL'), backgroundColor: Colors.red, labelStyle: TextStyle(color: Colors.white)),
              const Divider(height: 32),
              _buildDetail('Age', '${record.age}'),
              _buildDetail('Status', record.status.name.toUpperCase()),
              _buildDetail('Camp', record.camp),
              _buildDetail('Officer', record.officerName),
              _buildDetail('Contact', record.officerContact),
              if (record.lastKnownClothing != null)
                _buildDetail('Last Clothing', record.lastKnownClothing!),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Update Status'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
