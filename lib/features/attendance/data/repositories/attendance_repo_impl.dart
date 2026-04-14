import 'package:mica_school_app/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';
import 'package:mica_school_app/features/attendance/domain/repositories/attendance_repo.dart';




class AttendanceRepoImpl implements AttendanceRepo {
  final AttendanceRemoteDataSource attendanceRemoteDataSource;

  AttendanceRepoImpl({required this.attendanceRemoteDataSource});


  
  @override
  Stream<List<AttendanceScanEntity>> getRecentScans() =>
    attendanceRemoteDataSource.getRecentScans();

    @override
  Stream<List<AttendanceLogEntity>> getUserLogs(String userId) =>
    attendanceRemoteDataSource.getUserLogs(userId);





    
}