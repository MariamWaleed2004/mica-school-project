// lib/features/homework/data/models/homework_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mica_school_app/features/homework/domain/entities/homework_entity.dart';

class HomeworkModel extends HomeworkEntity {
  const HomeworkModel({
    required super.id,
    required super.subjectAr,
    required super.subjectEn,
    required super.taskAr,
    required super.taskEn,
    required super.dueDate,
    required super.dueTextAr,
    required super.dueTextEn,
    required super.emoji,
    required super.color,
    required super.isDone,
    required super.createdAt,
  });

  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '').replaceAll('0x', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  // 🔥 دالة لتحويل أي نوع إلى DateTime
  static DateTime _parseToDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.parse(value);
    return DateTime.now();
  }

  factory HomeworkModel.fromMap(Map<String, dynamic> map, String docId) {
    return HomeworkModel(
      id: docId,
      subjectAr: map['subjectAr'] ?? '',
      subjectEn: map['subjectEn'] ?? '',
      taskAr: map['taskAr'] ?? '',
      taskEn: map['taskEn'] ?? '',
      dueDate: map['dueDate'] ?? '',
      dueTextAr: map['dueTextAr'] ?? '',
      dueTextEn: map['dueTextEn'] ?? '',
      emoji: map['emoji'] ?? '📝',
      color: map['color'] != null ? _hexToColor(map['color']) : Colors.blue,
      isDone: map['isDone'] ?? false,
      // 🔥 Handle both Timestamp and String
      createdAt: _parseToDateTime(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectAr': subjectAr,
      'subjectEn': subjectEn,
      'taskAr': taskAr,
      'taskEn': taskEn,
      'dueDate': dueDate,
      'dueTextAr': dueTextAr,
      'dueTextEn': dueTextEn,
      'emoji': emoji,
      'color': _colorToHex(color),
      'isDone': isDone,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}