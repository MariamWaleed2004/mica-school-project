import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/attendance/domain/usecases/get_user_logs_usecase.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_state.dart';


class AttendanceLogsCubit extends Cubit<AttendanceLogsState> {
  final GetStudentLogsUseCase getStudentLogsUseCase;

  StreamSubscription? _subscription;

  AttendanceLogsCubit({required this.getStudentLogsUseCase})
      : super(AttendanceLogsInitial());

  void getStudentLogs(String userId) {
    emit(AttendanceLogsLoading());

    _subscription?.cancel();

    _subscription = getStudentLogsUseCase(userId).listen(
      (logs) {
        emit(AttendanceLogsLoaded(logs));
      },
      onError: (error) {
        emit(AttendanceLogsError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}