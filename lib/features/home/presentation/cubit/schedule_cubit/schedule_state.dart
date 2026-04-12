part of 'schedule_cubit.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

/// Initial state
final class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

/// Loading state
final class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

/// Loaded state (contains data)
final class ScheduleLoaded extends ScheduleState {
  final List<SubjectEntity> subjects;
  final List<ExamEntity> exams;

  const ScheduleLoaded({required this.subjects, required this.exams});

  @override
  List<Object?> get props => [subjects, exams];
}

/// Failure state (error handling)
final class ScheduleFailure extends ScheduleState {
  final String errorMessage;

  const ScheduleFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}