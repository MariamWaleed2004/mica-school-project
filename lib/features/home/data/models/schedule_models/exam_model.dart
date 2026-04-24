import 'package:flutter/material.dart';
import 'package:mica_school_app/core/utils.dart';
import 'package:mica_school_app/features/home/domain/entities/schedule_entities/exam_entity.dart';

class ExamModel extends ExamEntity {
  const ExamModel({
    required String id,
    required String nameAr,
    required String nameEn,
    required Color color,
    required String dateEn,
    required String dateAr,
    required String icon,
  }) : super(
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          color: color,
          dateEn: dateEn,
          dateAr: dateAr,
          icon: icon,

        );


  IconData get iconData => AppIcons.get(icon);

  // 🔥 Convert HEX → Color
  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '').replaceAll('0x', '');

    if (hex.length == 6) {
      hex = 'FF$hex'; // add opacity if missing
    }

    return Color(int.parse(hex, radix: 16));
  }


static String _colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
}

  factory ExamModel.fromMap(Map<String, dynamic> map, String docId) {
    return ExamModel(
      id: docId,
      dateEn: map['dateEn'] as String? ?? 'N/A',
      dateAr: map['dateAr'] as String? ?? 'N/A',
      icon: map['icon'] as String? ?? '❓',
      nameAr: map['nameAr'] as String? ?? 'غير معروف',
      nameEn: map['nameEn'] as String? ?? 'Unknown',

      // ✅ FIXED HERE
      color: map['color'] != null
          ? _hexToColor(map['color'])
          : Colors.grey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateEn': dateEn,
      'dateAr': dateAr,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'icon': icon,
      'color': _colorToHex(color),
    };
  }
}