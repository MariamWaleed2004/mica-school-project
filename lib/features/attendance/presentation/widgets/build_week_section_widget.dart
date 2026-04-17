import 'package:flutter/material.dart';

class AttendanceWeekSection extends StatelessWidget {
  final int weekNum;
  final bool isAr;
  final bool isDark;
  final List logs;
  final String monthName;
  final Color cardColor;
  final Color textColor;
  final int currentYear;
  final int Function(String) getMonthNumber;
  final String? Function(int, String, int, int) getDateForWeekDay;

  const AttendanceWeekSection({
    super.key,
    required this.weekNum,
    required this.isAr,
    required this.isDark,
    required this.logs,
    required this.monthName,
    required this.cardColor,
    required this.textColor,
    required this.currentYear,
    required this.getMonthNumber,
    required this.getDateForWeekDay,
  });

  @override
  Widget build(BuildContext context) {
    final daysAr = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];
    final daysEn = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];
    
    final monthNumber = getMonthNumber(monthName);
    final year = currentYear;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${isAr ? 'الأسبوع' : 'Week'} $weekNum",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF1D4ED8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        ...List.generate(5, (i) {
          final dayAr = daysAr[i];
          final dayName = isAr ? daysAr[i] : daysEn[i];
          final isHoliday = dayAr == 'الاثنين';
          
          final targetDate = getDateForWeekDay(weekNum, dayAr, monthNumber, year);
          
          bool isPresent = false;
          String logTime = '';
          
          if (targetDate != null) {
            final logsOnDate = logs.where((log) => log.date == targetDate).toList();
            
            if (logsOnDate.isNotEmpty) {
              isPresent = logsOnDate.any((log) => 
                log.eventType == "CHECK_IN" || log.eventType == "ATTENDANCE"
              );
              if (logsOnDate.isNotEmpty) {
                logTime = logsOnDate.first.time;
              }
            }
          }
          
          if (targetDate == null) {
            return const SizedBox.shrink();
          }
          
          Color statusColor = isHoliday
              ? const Color(0xFFF59E0B)
              : (isPresent ? const Color(0xFF10B981) : const Color(0xFFEF4444));
              
          IconData statusIcon = isHoliday
              ? Icons.beach_access_rounded
              : (isPresent ? Icons.check_circle_rounded : Icons.cancel_rounded);
              
          String statusText = isHoliday
              ? (isAr ? "إجازة" : "Holiday")
              : (isPresent
                  ? (isAr ? "حضور" : "Present")
                  : (isAr ? "غياب" : "Absent"));

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: statusColor.withOpacity(0.15)),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: textColor,
                        ),
                      ),
                      if (isPresent && logTime.isNotEmpty)
                        Text(
                          logTime,
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor.withOpacity(0.6),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}