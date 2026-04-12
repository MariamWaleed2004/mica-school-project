import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ExamEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String dateEn;
  final String dateAr;
  final Color color;
  final String icon;




  const ExamEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.dateEn,
    required this.dateAr,
    required this.color,
    required this.icon,

  });

  @override
  List<Object?> get props => [
        id,
        nameAr,
        nameEn,
        dateEn,
        dateAr,
        color,
        icon,
      ];
}