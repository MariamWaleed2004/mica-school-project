import 'package:flutter/material.dart';
import 'package:mica_school_app/features/home/domain/entities/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required String id,
    required String time,
    required String roomNum,
    required String emoji,
    required String nameAr,
    required String nameEn,
    required Color color,
    required String labNum,
    required String majorId,
  }) : super(
          id: id,
          time: time,
          roomNum: roomNum,
          emoji: emoji,
          nameAr: nameAr,
          nameEn: nameEn,
          color: color,
          labNum: labNum,
          majorId: majorId,
        );

  // 🔥 Convert HEX → Color
  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '').replaceAll('0x', '');

    if (hex.length == 6) {
      hex = 'FF$hex'; // add opacity if missing
    }

    return Color(int.parse(hex, radix: 16));
  }

  // 🔥 Convert Color → HEX (for saving)
  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map, String docId) {
    return SubjectModel(
      id: docId,
      time: map['time'] as String? ?? 'N/A',
      roomNum: map['roomNum'] as String? ?? 'N/A',
      emoji: map['emoji'] as String? ?? '❓',
      labNum: map['labNum'] as String? ?? 'N/A',
      nameAr: map['nameAr'] as String? ?? 'غير معروف',
      nameEn: map['nameEn'] as String? ?? 'Unknown',
      majorId: map['majorId'] as String? ?? 'N/A',

      // ✅ FIXED HERE
      color: map['color'] != null
          ? _hexToColor(map['color'])
          : Colors.grey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'roomNum': roomNum,
      'emoji': emoji,
      'labNum': labNum,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'majorId': majorId,

      // ✅ Save as HEX string
      'color': _colorToHex(color),
    };
  }
}