import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SubjectEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String time;
  final String roomNum;
  final Color color;
  final String emoji;
  final String labNum;
  final String majorId;



  const SubjectEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.time,
    required this.roomNum,
    required this.color,
    required this.emoji,
    required this.labNum,
    required this.majorId,
  });

  @override
  List<Object?> get props => [
        id,
        nameAr,
        nameEn,
        time,
        roomNum,
        color,
        emoji,
        labNum,
        majorId
      ];
}