import 'package:mica_school_app/features/attendance/domain/entities/attendance_log_entity.dart';


abstract class AttendanceLogsState {}

class AttendanceLogsInitial extends AttendanceLogsState {}

class AttendanceLogsLoaded extends AttendanceLogsState {
  final List<AttendanceLogEntity> logs;

  AttendanceLogsLoaded(this.logs);
}

class AttendanceLogsLoading extends AttendanceLogsState {}

class AttendanceLogsError extends AttendanceLogsState {
  final String message;

  AttendanceLogsError(this.message);
}