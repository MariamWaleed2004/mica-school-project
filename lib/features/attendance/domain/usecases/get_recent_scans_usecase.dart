

import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';
import 'package:mica_school_app/features/attendance/domain/repositories/attendance_repo.dart';

class GetRecentScansUsecase {
  final AttendanceRepo repository;

  GetRecentScansUsecase({required this.repository});

  Stream<List<AttendanceScanEntity>> call() {
    return repository.getRecentScans();
  }
}