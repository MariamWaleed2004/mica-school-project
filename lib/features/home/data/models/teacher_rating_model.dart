// lib/features/home/data/models/teacher_rating_model.dart

import 'package:mica_school_app/features/home/domain/entities/teacher_rating_entity.dart';

class TeacherRatingModel extends TeacherRatingEntity {
  const TeacherRatingModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.subjectAr,
    required super.subjectEn,
    required super.rating,
    required super.commentAr,
    required super.commentEn,
    required super.icon,
    required super.colorHex,
    required super.order,
  });

  // 🔥 دالة لتحويل أي نوع إلى int
  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // 🔥 دالة لتحويل أي نوع إلى String
  static String _toString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  factory TeacherRatingModel.fromMap(Map<String, dynamic> map, String docId) {
    return TeacherRatingModel(
      id: docId,
      nameAr: _toString(map['nameAr']),
      nameEn: _toString(map['nameEn']),
      subjectAr: _toString(map['subjectAr']),
      subjectEn: _toString(map['subjectEn']),
      rating: _toInt(map['rating']),  // 🔥 تحويل آمن
      commentAr: _toString(map['commentAr']),
      commentEn: _toString(map['commentEn']),
      icon: _toString(map['icon']),
      colorHex: _toString(map['color']),
      order: _toInt(map['order']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'subjectAr': subjectAr,
      'subjectEn': subjectEn,
      'rating': rating,
      'commentAr': commentAr,
      'commentEn': commentEn,
      'icon': icon,
      'color': colorHex,
      'order': order,
    };
  }
}