import 'package:flutter/material.dart';
import 'package:mica_school_app/features/attendance/presentation/widgets/header_state_card_widget.dart';

class AttendanceHeaderWidget extends StatelessWidget {
  final bool isArabic;
  final bool isDark;
  final int attendedDays;
  final int absentDays;
  final double attendanceRate;
  final int selectedMonthIndex;
  final List<String> monthsAr;
  final List<String> monthsEn;
  final Function(int) onMonthChanged;

  const AttendanceHeaderWidget({
    super.key,
    required this.isArabic,
    required this.isDark,
    required this.attendedDays,
    required this.absentDays,
    required this.attendanceRate,
    required this.selectedMonthIndex,
    required this.monthsAr,
    required this.monthsEn,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔥 أيقونة التقويم بس (من غير مربع ومن غير اسم شهر)
                  _buildMonthPicker(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        isArabic ? "سجل الحضور" : "Attendance Log",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        isArabic ? "متابعة الحضور" : "Track Presence",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Stats row
              Row(
                children: [
                  HeaderStatCard(
                    title: isArabic ? "أيام الحضور" : "Attended",
                    value: "$attendedDays",
                    color: const Color(0xFF10B981),
                    icon: Icons.check_circle_rounded,
                  ),
                  const SizedBox(width: 12),
                  HeaderStatCard(
                    title: isArabic ? "أيام الغياب" : "Absent",
                    value: "$absentDays",
                    color: const Color(0xFFEF4444),
                    icon: Icons.cancel_rounded,
                  ),
                  const SizedBox(width: 12),
                  HeaderStatCard(
                    title: isArabic ? "معدل الحضور" : "Rate",
                    value: "${(attendanceRate * 100).toInt()}%",
                    color: const Color(0xFFF59E0B),
                    icon: Icons.bar_chart_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: attendanceRate,
                  minHeight: 8,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    attendanceRate > 0.8
                        ? const Color(0xFF10B981)
                        : const Color(0xFFF59E0B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return Container(
      // 🔥 مفيش خلفية ولا حدود ولا padding
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedMonthIndex,
          icon: const Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: 28,
          ),
          // 🔥 خلي الـ icon بس من غير نص
          dropdownColor: const Color(0xFF1D4ED8),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          items: List.generate(
            monthsAr.length,
            (i) => DropdownMenuItem(
              value: i,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  isArabic ? monthsAr[i] : monthsEn[i],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            if (value != null) {
              onMonthChanged(value);
            }
          },
        ),
      ),
    );
  }
}