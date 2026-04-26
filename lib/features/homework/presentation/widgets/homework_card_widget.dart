// lib/features/home/presentation/widgets/homework_card_widget.dart

import 'package:flutter/material.dart';

class HomeworkCardWidget extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final Color cardColor;
  final Color textColor;
  final VoidCallback onTap;

  const HomeworkCardWidget({
    super.key,
    required this.isDark,
    required this.isArabic,
    required this.cardColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1e1b4b).withOpacity(0.8),
                    const Color(0xFF1E293B),
                  ]
                : [const Color(0xFFf5f3ff), Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text("📚", style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? "الواجبات المدرسية" : "School Homework",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    isArabic
                        ? "تابع واجباتك"
                        : "Check your homework",
                    style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF6366F1),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}