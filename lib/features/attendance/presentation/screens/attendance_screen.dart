import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_cubit.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_state.dart';
import 'package:mica_school_app/features/attendance/presentation/widgets/attendance_header_widget.dart';
import 'package:mica_school_app/features/attendance/presentation/widgets/build_week_section_widget.dart';
// 🔥 أضيفي الاستيراد

class AttendanceScreen extends StatefulWidget {
  final bool isArabic;
  final bool isDarkMode;
  final Map<String, String> texts;
  final String userId;

  const AttendanceScreen({
    super.key,
    required this.isArabic,
    required this.isDarkMode,
    required this.texts,
    required this.userId,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> with SingleTickerProviderStateMixin {
  int _selectedMonthIndex = 3; // أبريل
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  final List<String> _monthsAr = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',

  ];
  final List<String> _monthsEn = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];




  int _currentYear = 2024;


  @override
  void initState() {
    super.initState();
    print("USER ID IN ATTENDANCE: ${widget.userId}");
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    
    context.read<AttendanceLogsCubit>().getStudentLogs(widget.userId);
  }




  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  void _changeMonth(int val) {
    _controller.reset();
    setState(() => _selectedMonthIndex = val);
    _controller.forward();
  }




  int _getMonthNumber(String monthName) {
    switch (monthName) {
      case 'يناير': return 1;
      case 'فبراير': return 2;
      case 'مارس': return 3;
      case 'أبريل': return 4;
      case 'مايو': return 5;
      case 'يونيو': return 6;
      case 'يوليو': return 7;
      case 'أغسطس': return 8;
      case 'سبتمبر': return 9;
      case 'أكتوبر': return 10;
      case 'نوفمبر': return 11;
      case 'ديسمبر': return 12;
      default: return DateTime.now().month;
    }
  }




  List _filterLogsByMonth(List logs, int monthIndex) {
    final monthName = _monthsAr[monthIndex];
    final targetMonth = _getMonthNumber(monthName);
    
    int targetYear = _currentYear;
    if (logs.isNotEmpty) {
      final firstLogDate = logs.first.date.split('-');
      if (firstLogDate.length >= 1) {
        targetYear = int.parse(firstLogDate[0]);
        if (_currentYear != targetYear) {
          _currentYear = targetYear;
        }
      }
    }
    return logs.where((log) {
      final parts = log.date.split('-');
      if (parts.length < 2) return false;
      final logMonth = int.parse(parts[1]);
      final logYear = int.parse(parts[0]);
      return logMonth == targetMonth && logYear == targetYear;
    }).toList();
  }




  String? _getDateForWeekDay(int weekNum, String dayAr, int month, int year) {
    final daysOrder = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];
    final dayIndex = daysOrder.indexOf(dayAr);
    if (dayIndex == -1) return null;
    
    final firstDayOfMonth = DateTime(year, month, 1);
    int daysToFirstSunday = (7 - firstDayOfMonth.weekday) % 7;
    final firstSunday = firstDayOfMonth.add(Duration(days: daysToFirstSunday));
    final targetDate = firstSunday.add(Duration(days: (weekNum - 1) * 7 + dayIndex));
    
    if (targetDate.month != month) return null;
    return "${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}";
  }




  int _getTotalSchoolDaysInMonth(int month, int year) {
    int schoolDays = 0;
    DateTime date = DateTime(year, month, 1);
    while (date.month == month) {
      int weekday = date.weekday;
      if (weekday == 7 || weekday == 1 || weekday == 2 || weekday == 3 || weekday == 4) {
        schoolDays++;
      }
      date = date.add(const Duration(days: 1));
    }
    return schoolDays;
  }





  Map<String, dynamic> _calculateMonthStats(List logs, int month, int year) {
    final attendedDaysSet = <String>{};
    for (final log in logs) {
      if (log.eventType == "CHECK_IN" || log.eventType == "ATTENDANCE") {
        attendedDaysSet.add(log.date);
      }
    }
    final attendedDays = attendedDaysSet.length;
    final totalSchoolDays = _getTotalSchoolDaysInMonth(month, year);
    final absentDays = (totalSchoolDays - attendedDays).clamp(0, totalSchoolDays);
    final attendanceRate = totalSchoolDays > 0 ? attendedDays / totalSchoolDays : 0.0;
    
    return {
      'attended': attendedDays,
      'absent': absentDays,
      'rate': attendanceRate,
    };
  }





  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final isAr = widget.isArabic;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

    return BlocBuilder<AttendanceLogsCubit, AttendanceLogsState>(
      builder: (context, state) {
        if (state is AttendanceLogsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is AttendanceLogsError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        
        if (state is AttendanceLogsLoaded) {
          final allLogs = state.logs;
          final monthLogs = _filterLogsByMonth(allLogs, _selectedMonthIndex);
          final currentMonth = _getMonthNumber(_monthsAr[_selectedMonthIndex]);
          final stats = _calculateMonthStats(monthLogs, currentMonth, _currentYear);
          
          return RefreshIndicator(
            onRefresh: () async {
            context.read<AttendanceLogsCubit>().getStudentLogs(widget.userId);
            return Future.value();
          },
            child: Directionality(
              textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
              child: Scaffold(
                backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),
                body: FadeTransition(
                  opacity: _fadeAnim,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        AttendanceHeaderWidget(
                          isArabic: isAr,
                          isDark: isDark,
                          attendedDays: stats['attended'],
                          absentDays: stats['absent'],
                          attendanceRate: stats['rate'],
                          selectedMonthIndex: _selectedMonthIndex,
                          monthsAr: _monthsAr,
                          monthsEn: _monthsEn,
                          onMonthChanged: (newIndex) {
                            _changeMonth(newIndex);
                          },
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: List.generate(
                              4,
                              (i) => AttendanceWeekSection(
                                weekNum: i + 1,
                                isAr: isAr,
                                isDark: isDark,
                                logs: monthLogs,
                                monthName: _monthsAr[_selectedMonthIndex],
                                cardColor: cardColor,
                                textColor: textColor,
                                currentYear: _currentYear,
                                getMonthNumber: _getMonthNumber,
                                getDateForWeekDay: _getDateForWeekDay,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        
        return const SizedBox();
      },
    );
  }
}