import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_cubit.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_state.dart';
import 'package:mica_school_app/features/attendance/presentation/widgets/attendance_header_widget.dart';
import 'package:mica_school_app/features/home/presentation/widgets/build_header.dart';

class AttendanceScreen extends StatefulWidget {
  final bool isArabic;
  final bool isDarkMode;
  final Map<String, String> texts;
  //final String userId;

  const AttendanceScreen({
    super.key,
    required this.isArabic,
    required this.isDarkMode,
    required this.texts,
    //required this.userId,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  int _selectedMonthIndex = 1;
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  final List<String> _monthsAr = [
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
  ];
  final List<String> _monthsEn = [
    'September',
    'October',
    'November',
    'December',
    'February',
    'March',
    'April',
    'May',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    //context
      //.read<AttendanceLogsCubit>()
      //.getStudentLogs(widget.userId);
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

  int _calculateAttendedDays(List logs) {
    final uniqueDays = <String>{};

    for (final log in logs) {
      if (log.eventType == "CHECK_IN" || log.eventType == "ATTENDANCE") {
        uniqueDays.add(log.date);
      }
    }

    return uniqueDays.length;
  }

  //-----------------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final isAr = widget.isArabic;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

    final Map<int, List<String>> detailedAbsence = {
      0: ['الأسبوع 4-الأحد'],
      1: ['الأسبوع 2-الأحد', 'الأسبوع 4-الخميس'],
      2: ['الأسبوع 1-الثلاثاء', 'الأسبوع 3-الأحد'],
      3: ['الأسبوع 1-الخميس', 'الأسبوع 2-الأحد', 'الأسبوع 4-الأربعاء'],
    };

    final absents = detailedAbsence[_selectedMonthIndex] ?? [];
    const totalDays = 20;
    final absentCount = absents.length;
    final attendedCount = totalDays - absentCount;
    final attendPct = attendedCount / totalDays;

    return BlocConsumer<AttendanceLogsCubit, AttendanceLogsState>(
      listener: (context, state) {},
      builder: (context, state) {


        if (state is AttendanceLogsLoading) {
  return const Center(child: CircularProgressIndicator());
}
        if(state is AttendanceLogsLoaded) {


// 🔥 1. attended days (unique dates)
final logs = state.logs;

// 🔥 1. نجمع أيام الحضور (Unique Days)
final attendedDaysSet = <String>{};

for (final log in logs) {
  if (log.eventType == "CHECK_IN" || log.eventType == "ATTENDANCE") {
    attendedDaysSet.add(log.date); // كل يوم مرة واحدة فقط
  }
  print("EVENT TYPE: ${log.eventType}");
  print("DATE: ${log.date}");
}

// 🔥 2. عدد أيام الحضور
final attendedDays = attendedDaysSet.length;

// 🔥 3. نجمع كل الأيام الموجودة في الداتا (مش مثالي لكن مؤقت)
final allDaysSet = <String>{};

for (final log in logs) {
  allDaysSet.add(log.date);
}

// 🔥 4. إجمالي الأيام (fallback)
final totalDays = allDaysSet.isEmpty ? 1 : allDaysSet.length;

// 🔥 5. أيام الغياب
final absentDays = (totalDays - attendedDays).clamp(0, totalDays);

// 🔥 6. نسبة الحضور
final attendanceRate = attendedDays / totalDays;

for (final log in logs) {
  allDaysSet.add(log.date);
}



          return Directionality(
          textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: isDark
                ? const Color(0xFF0F172A)
                : const Color(0xFFF0F4FF),
            body: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    AttendanceHeaderWidget(
                      isArabic: widget.isArabic,
                      isDark: widget.isDarkMode,
                      attendedDays: attendedDays,
                      absentDays: absentDays,
                      attendanceRate: attendanceRate,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: List.generate(
                          4,
                          (i) => _buildWeekSection(
                            i + 1,
                            isAr,
                            isDark,
                            absents,
                            cardColor,
                            textColor,
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
        );
        }
         return const Text("Error loading user data");
      },
     
    );
  }


  Widget _headerStatCard(
    String label,
    String val,
    Color color,
    IconData icon,
  ) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            val,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 10),
          ),
        ],
      ),
    ),
  );

  Widget _buildMonthPicker(bool isAr, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedMonthIndex,
          dropdownColor: const Color(0xFF1D4ED8),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 20,
          ),
          items: List.generate(
            8,
            (i) => DropdownMenuItem(
              value: i,
              child: Text(
                isAr ? _monthsAr[i] : _monthsEn[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          onChanged: (v) => _changeMonth(v!),
        ),
      ),
    );
  }

  Widget _buildWeekSection(
    int weekNum,
    bool isAr,
    bool isDark,
    List<String> absents,
    Color cardColor,
    Color textColor,
  ) {
    final daysAr = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];
    final daysEn = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];

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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
          final isAbsent = absents.contains("الأسبوع $weekNum-$dayAr");

          Color statusColor = isHoliday
              ? const Color(0xFFF59E0B)
              : (isAbsent ? const Color(0xFFEF4444) : const Color(0xFF10B981));
          IconData statusIcon = isHoliday
              ? Icons.beach_access_rounded
              : (isAbsent ? Icons.cancel_rounded : Icons.check_circle_rounded);
          String statusText = isHoliday
              ? (isAr ? "إجازة" : "Holiday")
              : (isAbsent
                    ? (isAr ? "غياب" : "Absent")
                    : (isAr ? "حضور" : "Present"));

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
                  child: Text(
                    dayName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_scan_cubit/attendance_scan_cubit.dart';
// import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_scan_cubit/attendance_scan_state.dart';


// class AttendancePage extends StatefulWidget {
//   final bool isArabic;
//   final bool isDarkMode;
//   final Map<String, String> texts;

//   const AttendancePage({
//     super.key,
//     required this.isArabic,
//     required this.isDarkMode,
//     required this.texts,
//   });

//   @override
//   State<AttendancePage> createState() => _AttendancePageState();
// }

// class _AttendancePageState extends State<AttendancePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnim;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
//     _controller.forward();

//     // 🔥 أهم سطر
//     context.read<AttendanceScanCubit>().listenToScans();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = widget.isDarkMode;
//     final isAr = widget.isArabic;
//     final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
//     final textColor = isDark ? Colors.white : const Color(0xFF0D1333);

//     return Directionality(
//       textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor:
//             isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF),

//         body: BlocBuilder<AttendanceScanCubit, AttendanceScanState>(
//           builder: (context, state) {
//             /// 🔄 Loading
//             if (state is AttendanceScanLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             /// ❌ Error
//             if (state is AttendanceScanError) {
//               return Center(child: Text(state.message));
//             }

//             /// ✅ Loaded
//             if (state is AttendanceScanLoaded) {
//               final scans = state.attendanceScans;

//               // 🔥 نحسب الحضور والغياب
//               int attendedCount =
//                   scans.where((e) => e.event == "CHECK_IN").length;
//               int absentCount =
//                   scans.where((e) => e.event == "CHECK_OUT").length;

//               int total = scans.length == 0 ? 1 : scans.length;
//               double pct = attendedCount / total;

//               return FadeTransition(
//                 opacity: _fadeAnim,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       _buildHeader(
//                           isAr, isDark, attendedCount, absentCount, pct),

//                       /// 🔥 بدل الأسابيع القديمة → نعرض scans
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: scans.length,
//                         itemBuilder: (context, index) {
//                           final scan = scans[index];

//                           bool isCheckIn = scan.event == "CHECK_IN";

//                           Color statusColor = isCheckIn
//                               ? const Color(0xFF10B981)
//                               : const Color(0xFFEF4444);

//                           IconData icon = isCheckIn
//                               ? Icons.check_circle_rounded
//                               : Icons.cancel_rounded;

//                           String text = isCheckIn
//                               ? (isAr ? "حضور" : "Check In")
//                               : (isAr ? "خروج" : "Check Out");

//                           return Container(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 6),
//                             padding: const EdgeInsets.all(14),
//                             decoration: BoxDecoration(
//                               color: cardColor,
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(icon, color: statusColor),
//                                 const SizedBox(width: 12),

//                                 /// name
//                                 Expanded(
//                                   child: Text(scan.name,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: textColor)),
//                                 ),

//                                 /// event
//                                 Text(text,
//                                     style: TextStyle(
//                                         color: statusColor,
//                                         fontWeight: FontWeight.bold)),

//                                 const SizedBox(width: 10),

//                                 /// time
//                                 Text(scan.time,
//                                     style: TextStyle(color: textColor)),
//                               ],
//                             ),
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(bool isAr, bool isDark, int att, int abs, double pct) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(32),
//           bottomRight: Radius.circular(32),
//         ),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
//           child: Column(children: [
//             Text(isAr ? "سجل الحضور" : "Attendance",
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold)),

//             const SizedBox(height: 20),

//             Row(children: [
//               _stat("Attended", "$att", const Color(0xFF10B981)),
//               const SizedBox(width: 10),
//               _stat("Absent", "$abs", const Color(0xFFEF4444)),
//               const SizedBox(width: 10),
//               _stat("Rate", "${(pct * 100).toInt()}%",
//                   const Color(0xFFF59E0B)),
//             ])
//           ]),
//         ),
//       ),
//     );
//   }

//   Widget _stat(String label, String val, Color color) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Text(val,
//                 style: TextStyle(
//                     color: color,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18)),
//             Text(label,
//                 style: const TextStyle(color: Colors.white70, fontSize: 10))
//           ],
//         ),
//       ),
//     );
//   }
// }