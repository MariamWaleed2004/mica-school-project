import 'package:flutter/material.dart';

class ScheduleCardWidget extends StatelessWidget {
    final Function(String) onNavigate;
    final bool isDark;
    final bool isArabic;

    
  const ScheduleCardWidget({
    super.key, 
    required this.isDark, 
    required this.onNavigate, 
    required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
    const accentColor = Color(0xFF4F46E5);
    return GestureDetector(
      onTap: () => onNavigate("schedule"),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1e1b4b).withOpacity(0.8),
                    const Color(0xFF1E293B),
                  ]
                : [const Color(0xFFEEF2FF), Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.08),
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
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                color: accentColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? "الجدول الدراسي" : "School Schedule",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    isArabic
                        ? "عرض الحصص والمواعيد اليومية"
                        : "View daily classes & timing",
                    style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: accentColor, size: 16),
          ],
        ),
      ),
    );
  }
}
