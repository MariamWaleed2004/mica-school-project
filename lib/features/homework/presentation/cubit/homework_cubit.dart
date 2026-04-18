// lib/features/homework/presentation/cubit/homework_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';
import 'package:mica_school_app/features/homework/domain/usecases/get_homework_usecase.dart';
import 'package:mica_school_app/features/homework/domain/usecases/toggle_homework_status_usecase.dart';
import 'package:mica_school_app/features/homework/presentation/cubit/homework_state.dart';

class HomeworkCubit extends Cubit<HomeworkState> {
  final GetHomeworkUsecase getHomeworkUsecase;
  final ToggleHomeworkStatusUsecase toggleHomeworkStatusUsecase;

  HomeworkCubit({
    required this.getHomeworkUsecase,
    required this.toggleHomeworkStatusUsecase,
  }) : super(const HomeworkInitial());

  Future<void> getHomeworks(String userId) async {
    emit(const HomeworkLoading());
    try {
      final homeworks = await getHomeworkUsecase(userId);
      emit(HomeworkLoaded(homeworks: homeworks));
    } catch (e) {
      emit(HomeworkError(message: e.toString()));
    }
  }

  Future<void> toggleHomeworkStatus(
    String userId,
    String homeworkId,
    bool currentStatus,
  ) async {
    try {
      await toggleHomeworkStatusUsecase(userId, homeworkId, currentStatus);
      
      if (state is HomeworkLoaded) {
        final currentState = state as HomeworkLoaded;
        final updatedHomeworks = currentState.homeworks.map((homework) {
          if (homework.id == homeworkId) {
            return HomeworkEntity(
              id: homework.id,
              subjectAr: homework.subjectAr,
              subjectEn: homework.subjectEn,
              taskAr: homework.taskAr,
              taskEn: homework.taskEn,
              dueDate: homework.dueDate,
              dueTextAr: homework.dueTextAr,
              dueTextEn: homework.dueTextEn,
              emoji: homework.emoji,
              color: homework.color,
              isDone: !currentStatus,
              createdAt: homework.createdAt,
       
            );
          }
          return homework;
        }).toList();
        
        emit(HomeworkLoaded(homeworks: updatedHomeworks));
      }
    } catch (e) {
      emit(HomeworkError(message: e.toString()));
    }
  }
}