import 'package:mica_school_app/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';


abstract class AttendanceRepo {


  Stream<List<AttendanceScanEntity>> getRecentScans();
  Stream<List<AttendanceLogEntity>> getUserLogs(String userId);


}