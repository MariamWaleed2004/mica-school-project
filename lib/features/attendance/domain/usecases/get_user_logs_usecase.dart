import 'package:mica_school_app/features/attendance/domain/repositories/attendance_repo.dart';
import '../entities/attendance_log_entity.dart';

class GetStudentLogsUseCase {
  final AttendanceRepo repository;

  GetStudentLogsUseCase({required this.repository});

  Stream<List<AttendanceLogEntity>> call(String studentId) {
    return repository.getUserLogs(studentId);
  }
}