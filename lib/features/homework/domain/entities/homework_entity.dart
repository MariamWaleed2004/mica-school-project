// lib/features/homework/domain/entities/homework_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeworkEntity extends Equatable {
  final String id;
  final String subjectAr;
  final String subjectEn;
  final String taskAr;
  final String taskEn;
  final String dueDate;
  final String dueTextAr;
  final String dueTextEn;
  final String emoji;
  final Color color;  
  final bool isDone;
  final DateTime createdAt;


  const HomeworkEntity({
    required this.id,
    required this.subjectAr,
    required this.subjectEn,
    required this.taskAr,
    required this.taskEn,
    required this.dueDate,
    required this.dueTextAr,
    required this.dueTextEn,
    required this.emoji,
    required this.color,
    required this.isDone,
    required this.createdAt,
  
  });

  @override
  List<Object?> get props => [
        id,
        subjectAr,
        subjectEn,
        taskAr,
        taskEn,
        dueDate,
        dueTextAr,
        dueTextEn,
        emoji,
        color,
        isDone,
        createdAt,

      ];
}