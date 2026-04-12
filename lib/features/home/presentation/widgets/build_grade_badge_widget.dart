import 'package:flutter/material.dart';

class BuildGradeBadgeWidget extends StatelessWidget {
  final bool isArabic;
  final bool isDark;
  final Color cardColor;
  final Color textColor;
  final String? gradeAr;
  final String? gradeEn;
  final String? gradeNum;
  final String? majorEn;
  final String? majorAr;

  const BuildGradeBadgeWidget({
    super.key,
    required this.isArabic,
    required this.isDark,
    required this.cardColor,
    required this.textColor,
    required this.gradeAr,
    required this.gradeEn,
    required this.gradeNum,
    required this.majorEn,
    required this.majorAr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "3",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            isArabic
                ? "${gradeAr ?? ''} • ${majorAr ?? ''}"
                : "${gradeEn ?? ''} • ${majorEn ?? ''}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
