// lib/features/canteen/presentation/widgets/month_picker_widget.dart

import 'package:flutter/material.dart';

class MonthPickerWidget extends StatelessWidget {
  final bool isDark;
  final List<String> months;
  final String selectedMonth;
  final bool isArabic;
  final Function(String?) onMonthChanged;

  final Map<String, String> monthTranslations = {
    "September": "سبتمبر", "October": "أكتوبر", "November": "نوفمبر",
    "December": "ديسمبر", "January": "يناير", "February": "فبراير",
    "March": "مارس", "April": "أبريل", "May": "مايو", "June": "يونيو",
    "July": "يوليو", "August": "أغسطس",
  };

   MonthPickerWidget({
    super.key,
    required this.isDark,
    required this.months,
    required this.selectedMonth,
    required this.isArabic,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF1D4ED8)]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: const Color(0xFF1D4ED8).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMonth,
          dropdownColor: const Color(0xFF1A237E),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 20),
          onChanged: onMonthChanged,
          items: months.map((m) {
            return DropdownMenuItem(
              value: m,
              child: Text(
                isArabic ? monthTranslations[m]! : m,
                style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}