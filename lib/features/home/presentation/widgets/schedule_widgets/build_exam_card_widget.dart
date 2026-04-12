import 'package:flutter/material.dart';
import 'package:mica_school_app/core/utils.dart';
import 'package:mica_school_app/features/home/domain/entities/exam_entity.dart';

class BuildExamCardWidget extends StatelessWidget {
  final ExamEntity exam;
  final Color cardColor;
  final Color textColor;
  final bool isDark;
  final bool isArabic;

  const BuildExamCardWidget({
    super.key,
    required this.exam,
    required this.cardColor,
    required this.textColor,
    required this.isDark,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final color = exam.color;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Icon(
                  AppIcons.get(exam.icon),
                  color: color,
                  size: 18,
                ),
                const SizedBox(height: 4),

          // ---------------------------- Exam Date -----------------------------------
                Text( isArabic ? exam.dateAr : exam.dateEn,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // -------------------------------- Exam Name --------------------------------
          Expanded(
            child: Text(
              isArabic ? exam.nameAr : exam.nameEn,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}