import '../../domain/entities/attendance_log_entity.dart';

class AttendanceLogModel extends AttendanceLogEntity {
  AttendanceLogModel({
    required super.uid,
    required super.studentId,
    required super.eventType,
    required super.gate,
    required super.date,
    required super.time,
    required super.timestamp,
  });


  factory AttendanceLogModel.fromMap(Map<String, dynamic> map) {
    return AttendanceLogModel(
      uid: map['uid'] ?? '',
      studentId: map['studentId'] ?? map['uid'] ?? '',
      eventType: map['eventType'] ?? '',
      gate: map['gate'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      timestamp: _parseTimestamp(map['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'studentId': studentId,
      'eventType': eventType,
      'gate': gate,
      'date': date,
      'time': time,
      'timestamp': timestamp,
    };
  }


  static int _parseTimestamp(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    return int.tryParse(value.toString()) ?? 0;
  }
}