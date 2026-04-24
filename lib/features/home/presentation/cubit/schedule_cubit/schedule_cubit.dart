import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/subject_entity.dart';
import 'package:mica_school_app/features/home/domain/usecases/schedule_usecases/get_exam_usecase.dart';
import 'package:mica_school_app/features/home/domain/usecases/schedule_usecases/get_subject_usecase.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final GetSubjectUsecase getSubjectUsecase;
  final GetExamUsecase getExamUsecase;

  ScheduleCubit({
    required this.getSubjectUsecase,
    required this.getExamUsecase,
  }) : super(const ScheduleInitial());


Future<void> getSchedule(String majorId) async {
    try {
      emit(const ScheduleLoading());

      final subjects = await getSubjectUsecase(majorId);
      final exams = await getExamUsecase(majorId);

      emit(ScheduleLoaded(
        subjects: subjects,
        exams: exams,
      ));
    } catch (e) {
      emit(ScheduleFailure(errorMessage: e.toString()));
    }
  }
}


