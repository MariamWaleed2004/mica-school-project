import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? id;
  final String? nameAr;
  final String? nameEn;
  final String? profileImageUrl;
  final String? password;
  final bool? isActive;
  final String? gradeEn;
  final String? gradeAr;
  final String? gradeNum;
  final String? majorEn;
  final String? majorAr;
  final String? majorId;


  UserEntity({
    this.uid,
    this.id,
    this.nameAr,
    this.nameEn,
    this.profileImageUrl,
    this.password,
    this.isActive,
    this.gradeEn,
    this.gradeAr,
    this.gradeNum,
    this.majorEn,
    this.majorAr,
    this.majorId,
  });

  @override
  List<Object?> get props => [
        uid,
        id,
        nameAr,
        nameEn,
        profileImageUrl,
        password,
        isActive,
        gradeEn,
        gradeAr,
        gradeNum,
        majorEn,
        majorAr,
        majorId
      ];
}
