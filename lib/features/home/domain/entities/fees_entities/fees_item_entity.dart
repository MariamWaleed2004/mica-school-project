import 'package:flutter/material.dart';
import 'package:mica_school_app/core/utils.dart';

class FeeItemEntity {
  final String id;
  final String titleAr;
  final String titleEn;
  final double amount;
  final String statusAr; 
  final String statusEn;  
  final String colorHex;
  final String iconName;
  final String category;

  const FeeItemEntity({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.amount,
    required this.statusAr,
    required this.statusEn,
    required this.colorHex,
    required this.iconName,
    required this.category,
  });

  Color get color {
    try {
      String hex = colorHex.replaceAll('#', '');
      hex = hex.replaceAll('0x', '');
      
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      
      final value = int.parse(hex, radix: 16);
      return Color(value);
    } catch (e) {
      return Colors.blue;
    }
  }

  IconData get icon => AppIcons.get(iconName);
  
  bool get isPaid => statusAr == 'مدفوع' || statusEn == 'Paid';
  
  String getDisplayStatus(bool isArabic) {
    return isArabic ? statusAr : statusEn;
  }
}