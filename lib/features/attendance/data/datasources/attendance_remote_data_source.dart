import 'package:mica_school_app/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';


abstract class  AttendanceRemoteDataSource{

  Stream<List<AttendanceScanEntity>> getRecentScans();
  Stream<List<AttendanceLogEntity>> getUserLogs(String userId);


}