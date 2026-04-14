class AttendanceLogEntity {
  final String uid;
  final String studentId;
  final String eventType;
  final String gate;
  final String date;
  final String time;
  final int timestamp;

  AttendanceLogEntity({
    required this.uid,
    required this.studentId,
    required this.eventType,
    required this.gate,
    required this.date,
    required this.time,
    required this.timestamp,
  });
}