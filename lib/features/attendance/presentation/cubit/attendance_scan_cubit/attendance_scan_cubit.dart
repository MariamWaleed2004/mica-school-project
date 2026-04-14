import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/attendance/domain/entities/attendance_scan_entity.dart';
import 'package:mica_school_app/features/attendance/domain/usecases/get_recent_scans_usecase.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_scan_cubit/attendance_scan_state.dart';

class AttendanceScanCubit extends Cubit<AttendanceScanState> {
  final GetRecentScansUsecase getRecentScansUsecase;

  AttendanceScanCubit({required this.getRecentScansUsecase})
      : super(AttendanceScanInitial());

  void listenToScans() {
    emit(AttendanceScanLoading());

    getRecentScansUsecase().listen(
      (data) {
        emit(AttendanceScanLoaded(data));
      },
      onError: (error) {
        emit(AttendanceScanError(error.toString()));
      },
    );
  }
}