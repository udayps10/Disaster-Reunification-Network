import 'package:flutter/material.dart';
import '../../../data/models/disaster_record.dart';
import '../../../core/common_widgets/app_button.dart';
import '../../../core/common_widgets/app_text_field.dart';

class AddRecordScreen extends StatefulWidget {
  final RecordType type;

  const AddRecordScreen({super.key, required this.type});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  RecordStatus _status = RecordStatus.found;

  @override
  Widget build(BuildContext context) {
    final isCritical = widget.type == RecordType.critical;

    return Scaffold(
      appBar: AppBar(
        title: Text(isCritical ? 'Add Critical Record' : 'Add Normal Person'),
        backgroundColor: isCritical ? Colors.red[900] : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCritical)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.red),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Critical/deceased photographs are confidential and must never be displayed to normal users.',
                        style: TextStyle(color: Colors.red[900], fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(isCritical ? 'Person Photo (Internal)' : 'Person Photo', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const AppTextField(label: 'Full Name', hint: 'Enter full name'),
            const SizedBox(height: 16),
            const AppTextField(label: 'Age', hint: 'Enter age', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            if (isCritical) ...[
              const AppTextField(label: 'Last Known Clothing', hint: 'Describe clothing in detail'),
              const SizedBox(height: 16),
              const Text('Clothing Photo (Optional)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Icon(Icons.add_a_photo, size: 24, color: Colors.grey),
              ),
              const SizedBox(height: 16),
            ],
            const AppTextField(label: 'Camp / Location Found', hint: 'Enter location'),
            const SizedBox(height: 16),
            const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<RecordStatus>(
              initialValue: _status,
              decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 16)),
              items: RecordStatus.values.map((s) => DropdownMenuItem(
                value: s,
                child: Text(s.name.toUpperCase()),
              )).toList(),
              onChanged: (val) => setState(() => _status = val!),
            ),
            const SizedBox(height: 16),
            const AppTextField(label: 'Officer Name', hint: 'Your name'),
            const SizedBox(height: 16),
            const AppTextField(label: 'Officer Contact', hint: 'Your contact number'),
            const SizedBox(height: 32),
            AppButton(
              text: 'Save Record',
              onPressed: () => _showSuccess(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record saved successfully (Mock)')),
    );
    Navigator.pop(context);
  }
}
