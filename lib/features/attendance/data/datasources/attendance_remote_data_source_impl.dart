import 'package:firebase_database/firebase_database.dart';
import 'package:mica_school_app/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:mica_school_app/features/attendance/data/models/attendance_log_model.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';

class AttendanceRemoteDataSourceImpl
    implements AttendanceRemoteDataSource {
  
  final DatabaseReference recentScansRef =
      FirebaseDatabase.instance.ref("recent_scans");

  final DatabaseReference studentsRef =
      FirebaseDatabase.instance.ref("students");

  @override
  Stream<List<AttendanceScanEntity>> getRecentScans() {
    return recentScansRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) return <AttendanceScanEntity>[];

      return data.values.map((e) {
        return AttendanceScanEntity(
          name: e['name'] ?? '',
          event: e['event'] ?? '',
          time: e['time'] ?? '',
        );
      }).toList();
    });
  }

  @override
  Stream<List<AttendanceLogEntity>> getUserLogs(String userId) {
    final ref = studentsRef.child('$userId/logs');

    return ref.onValue.map((event) {
      final data = event.snapshot.value;

      if (data == null) return <AttendanceLogEntity>[];

      final map = Map<String, dynamic>.from(data as Map);

      final logs = map.entries.map((e) {
        return AttendanceLogModel.fromMap(
          Map<String, dynamic>.from(e.value),
        );
      }).toList();

      logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return logs;
    });
  }
}