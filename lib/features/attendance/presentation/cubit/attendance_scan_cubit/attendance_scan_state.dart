import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';

abstract class AttendanceScanState {}

class AttendanceScanInitial extends AttendanceScanState {}

class AttendanceScanLoading extends AttendanceScanState {}

class AttendanceScanLoaded extends AttendanceScanState {
  final List<AttendanceScanEntity> attendanceScans;

  AttendanceScanLoaded(this.attendanceScans);
}

class AttendanceScanError extends AttendanceScanState {
  final String message;

  AttendanceScanError(this.message);
}