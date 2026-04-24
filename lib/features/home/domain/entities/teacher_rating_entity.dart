// lib/features/home/domain/entities/teacher_rating_entity.dart

import 'package:flutter/material.dart';

class TeacherRatingEntity {
  final String id;
  final String nameAr;
  final String nameEn;
  final String subjectAr;
  final String subjectEn;
  final int rating;  // 🔥 int
  final String commentAr;
  final String commentEn;
  final String icon;
  final String colorHex;
  final int order;

  const TeacherRatingEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.subjectAr,
    required this.subjectEn,
    required this.rating,
    required this.commentAr,
    required this.commentEn,
    required this.icon,
    required this.colorHex,
    required this.order,
  });

  Color get color {
    try {
      String hex = colorHex.replaceAll('#', '');
      hex = hex.replaceAll('0x', '');
      hex = hex.replaceAll('xFF', '');
      
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      
      if (hex.length != 8) {
        return Colors.blue;
      }
      
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      print("❌ Color parsing error: $colorHex");
      return Colors.blue;
    }
  }
}