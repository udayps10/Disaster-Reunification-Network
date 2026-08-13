import '../models/disaster_record.dart';

class MockRepository {
  static List<DisasterRecord> getMockRecords() {
    return [
      DisasterRecord(
        id: '1',
        fullName: 'Rahul Sharma',
        age: 24,
        photoUrl: 'https://via.placeholder.com/150',
        camp: 'Camp A12',
        officerName: 'Officer Amit',
        officerContact: '+91 98765 43210',
        dateTimeFound: DateTime.now().subtract(const Duration(days: 2)),
        status: RecordStatus.found,
        type: RecordType.normal,
        matchConfidence: 0.94,
      ),
      DisasterRecord(
        id: '2',
        fullName: 'Priya Patel',
        age: 19,
        photoUrl: 'https://via.placeholder.com/150',
        camp: 'Camp B5',
        officerName: 'Officer Sneha',
        officerContact: '+91 98765 11111',
        dateTimeFound: DateTime.now().subtract(const Duration(days: 1)),
        status: RecordStatus.atCamp,
        type: RecordType.normal,
        matchConfidence: 0.87,
      ),
      DisasterRecord(
        id: '3',
        fullName: 'Unknown Male',
        age: 30,
        photoUrl: 'https://via.placeholder.com/150',
        camp: 'Camp A12',
        officerName: 'Officer Amit',
        officerContact: '+91 98765 43210',
        dateTimeFound: DateTime.now().subtract(const Duration(hours: 12)),
        status: RecordStatus.found,
        type: RecordType.normal,
        matchConfidence: 0.82,
      ),
      DisasterRecord(
        id: '4',
        fullName: 'Anjali Verma',
        age: 45,
        photoUrl: 'https://via.placeholder.com/150',
        camp: 'Camp C2',
        officerName: 'Officer Rajesh',
        officerContact: '+91 98765 22222',
        dateTimeFound: DateTime.now().subtract(const Duration(days: 3)),
        status: RecordStatus.identified,
        type: RecordType.normal,
        matchConfidence: 0.75,
      ),
      // Critical Record
      DisasterRecord(
        id: 'c1',
        fullName: 'Vikram Singh',
        age: 52,
        photoUrl: 'https://via.placeholder.com/150', // Confidential
        lastKnownClothing: 'Blue full-sleeve shirt, Black jeans',
        camp: 'City Hospital',
        officerName: 'Dr. Mehra',
        officerContact: '+91 98765 33333',
        dateTimeFound: DateTime.now().subtract(const Duration(days: 1)),
        status: RecordStatus.found,
        type: RecordType.critical,
        matchConfidence: 0.91,
      ),
    ];
  }
}
