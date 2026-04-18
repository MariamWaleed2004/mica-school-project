// lib/features/homework/presentation/cubit/homework_state.dart

import 'package:equatable/equatable.dart';
import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';

sealed class HomeworkState extends Equatable {
  const HomeworkState();

  @override
  List<Object?> get props => [];
}

final class HomeworkInitial extends HomeworkState {
  const HomeworkInitial();
}

final class HomeworkLoading extends HomeworkState {
  const HomeworkLoading();
}

final class HomeworkLoaded extends HomeworkState {
  final List<HomeworkEntity> homeworks;

  const HomeworkLoaded({required this.homeworks});

  @override
  List<Object?> get props => [homeworks];
}

final class HomeworkError extends HomeworkState {
  final String message;

  const HomeworkError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class HomeworkToggled extends HomeworkState {
  const HomeworkToggled();
}