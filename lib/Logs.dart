// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class LogsPage extends StatefulWidget {
//   final bool isArabic;
//   final bool isDarkMode;
//   final XFile? profileImage;

//   const LogsPage({
//     super.key,
//     required this.isArabic,
//     required this.isDarkMode,
//     this.profileImage,
//   });

//   @override
//   State<LogsPage> createState() => _LogsPageState();
// }

// class _LogsPageState extends State<LogsPage> with TickerProviderStateMixin {
//   String selectedMonth = "March";
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnim;
//   late Animation<Offset> _slideAnim;

//   static const Color primary = Color(0xFF1A237E);
//   static const Color blue = Color(0xFF1D4ED8);
//   static const Color accent = Color(0xFF7C4DFF);
//   static const Color gold = Color(0xFFFFB300);

//   // ─── Translations ────────────────────────────────────────────────
//   String t(String ar, String en) => widget.isArabic ? ar : en;

//   final Map<String, String> monthsAr = {
//     "September": "سبتمبر",
//     "October": "أكتوبر",
//     "November": "نوفمبر",
//     "December": "ديسمبر",
//     "January": "يناير",
//     "February": "فبراير",
//     "March": "مارس",
//     "April": "أبريل",
//     "May": "مايو",
//     "June": "يونيو",
//     "July": "يوليو",
//   };

//   final Map<String, String> monthsEn = {
//     "September": "September",
//     "October": "October",
//     "November": "November",
//     "December": "December",
//     "January": "January",
//     "February": "February",
//     "March": "March",
//     "April": "April",
//     "May": "May",
//     "June": "June",
//     "July": "July",
//   };

//   Map<String, String> get monthsMap => widget.isArabic ? monthsAr : monthsEn;

//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 600));
//     _slideController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
//     _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
//         .animate(CurvedAnimation(
//             parent: _slideController, curve: Curves.easeOutCubic));
//     _fadeController.forward();
//     _slideController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }

//   void _changeMonth(String? v) {
//     if (v == null) return;
//     _fadeController.reset();
//     _slideController.reset();
//     setState(() => selectedMonth = v);
//     _fadeController.forward();
//     _slideController.forward();
//   }

//   // ─── Data ────────────────────────────────────────────────────────
//   Map<String, dynamic> get commonExamsData => {
//         "hasExams": true,
//         "exams": [
//           {
//             "day": widget.isArabic ? "الأربعاء" : "Wed",
//             "date": "04/03",
//             "sub": widget.isArabic
//                 ? "ذكاء اصطناعي / مشروعات برمجة + تك مقايسات"
//                 : "AI / Programming Projects + Tech Estimations",
//           },
//           {
//             "day": widget.isArabic ? "الخميس" : "Thu",
//             "date": "05/03",
//             "sub": widget.isArabic
//                 ? "ميكانيكا + لغة إنجليزية"
//                 : "Mechanics + English Language",
//           },
//           {
//             "day": widget.isArabic ? "الثلاثاء" : "Tue",
//             "date": "10/03",
//             "sub": widget.isArabic
//                 ? "عملي ذكاء اصطناعي (Lab 8)"
//                 : "AI Practical (Lab 8)",
//           },
//         ],
//         "revisions": [
//           {
//             "name": widget.isArabic
//                 ? "مراجعة ذكاء اصطناعي ومقايسات"
//                 : "AI & Estimations Revision",
//             "price": widget.isArabic ? "60 ج.م" : "60 EGP",
//             "day": widget.isArabic ? "الثلاثاء" : "Tuesday",
//             "time": widget.isArabic ? "قبل الامتحان" : "Before Exam",
//           },
//           {
//             "name": widget.isArabic
//                 ? "مراجعة ميكانيكا وإنجليزي"
//                 : "Mechanics & English Revision",
//             "price": widget.isArabic ? "50 ج.م" : "50 EGP",
//             "day": widget.isArabic ? "الأربعاء" : "Wednesday",
//             "time": widget.isArabic ? "قبل الامتحان" : "Before Exam",
//           },
//           {
//             "name": widget.isArabic
//                 ? "مراجعة عملي الذكاء (Lab 8)"
//                 : "AI Practical Revision (Lab 8)",
//             "price": widget.isArabic ? "50 ج.م" : "50 EGP",
//             "day": widget.isArabic ? "الإثنين" : "Monday",
//             "time": widget.isArabic ? "قبل الامتحان" : "Before Exam",
//           },
//         ],
//       };

//   Map<String, Map<String, dynamic>> get academicData => {
//         "January": {
//           "status": "released",
//           "total": "540/550",
//           "percent": "98.1%",
//           "rankAr": widget.isArabic ? "الخامس" : "5th",
//           "grades": _allGrades(98),
//           ...commonExamsData,
//         },
//         "February": {
//           "status": "released",
//           "total": "530/550",
//           "percent": "96.3%",
//           "rankAr": widget.isArabic ? "السابع" : "7th",
//           "grades": _allGrades(92),
//           ...commonExamsData,
//         },
//         "March": {
//           "status": "released",
//           "total": "548/550",
//           "percent": "99.6%",
//           "rankAr": widget.isArabic ? "الأول" : "1st",
//           "grades": _allGrades(99),
//           ...commonExamsData,
//         },
//         "April": {
//           "status": "upcoming",
//           "expected": widget.isArabic ? "15 مايو" : "May 15",
//           "hasExams": false,
//           "nextExam": widget.isArabic ? "15 أبريل" : "April 15",
//           "nextRev": widget.isArabic ? "16 أبريل" : "April 16",
//         },
//         "May": {
//           "status": "upcoming",
//           "expected": widget.isArabic ? "10 يونيو" : "June 10",
//           "hasExams": false,
//           "nextExam": widget.isArabic ? "18 مايو" : "May 18",
//           "nextRev": widget.isArabic ? "19 مايو" : "May 19",
//         },
//         "June": {
//           "status": "upcoming",
//           "expected": widget.isArabic ? "5 يوليو" : "July 5",
//           "hasExams": false,
//           "nextExam": widget.isArabic ? "8 يونيو" : "June 8",
//           "nextRev": widget.isArabic ? "9 يونيو" : "June 9",
//         },
//         "July": {
//           "status": "upcoming",
//           "expected": widget.isArabic ? "25 يوليو" : "July 25",
//           "hasExams": false,
//           "nextExam": widget.isArabic ? "1 يوليو" : "July 1",
//           "nextRev": widget.isArabic ? "2 يوليو" : "July 2",
//         },
//       };

//   List<Map<String, dynamic>> _allGrades(int base) => [
//         {
//           'label': widget.isArabic ? 'اللغة الإنجليزية' : 'English Language',
//           'score': '$base',
//           'max': '100',
//           'work': '20/20',
//           'icon': '📖',
//         },
//         {
//           'label': widget.isArabic ? 'الميكانيكا' : 'Mechanics',
//           'score': '48',
//           'max': '50',
//           'work': '10/10',
//           'icon': '⚙️',
//         },
//         {
//           'label':
//               widget.isArabic ? 'تكنولوجيا ومقايسات' : 'Tech & Estimations',
//           'score': '98',
//           'max': '100',
//           'work': '20/20',
//           'icon': '🔬',
//         },
//         {
//           'label': widget.isArabic ? 'إدارة مشروعات' : 'Project Management',
//           'score': '45',
//           'max': '50',
//           'work': '10/10',
//           'icon': '💻',
//         },
//         {
//           'label': widget.isArabic ? 'المواد العملية' : 'Practical Subjects',
//           'score': '295',
//           'max': '300',
//           'work': '60/60',
//           'icon': '🧪',
//         },
//       ];

//   // ─── Build ───────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     final isDark = widget.isDarkMode;
//     final isAr = widget.isArabic;
//     final currentData = academicData[selectedMonth] ?? academicData["March"]!;
//     final cardColor = isDark ? const Color(0xFF131929) : Colors.white;
//     final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
//     final bg = isDark ? const Color(0xFF090E1A) : const Color(0xFFF0F4FF);

//     return Directionality(
//       textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: bg,
//         body: Column(children: [
//           _buildHeader(context, isDark, currentData),
//           Expanded(
//             child: FadeTransition(
//               opacity: _fadeAnim,
//               child: SlideTransition(
//                 position: _slideAnim,
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.fromLTRB(18, 20, 18, 40),
//                   child: Column(children: [
//                     _buildProfileCard(cardColor, textColor, isDark),
//                     const SizedBox(height: 18),
//                     _buildMonthPicker(cardColor, textColor, isDark),
//                     const SizedBox(height: 22),
//                     if (currentData['status'] == "released") ...[
//                       _buildStatsGrid(currentData, isDark),
//                       const SizedBox(height: 18),
//                       _buildGradesList(
//                           currentData['grades'], cardColor, textColor, isDark),
//                       const SizedBox(height: 18),
//                       _buildSummaryCard(isDark),
//                     ] else ...[
//                       _buildUpcomingState(currentData['expected']),
//                     ],
//                   ]),
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }

//   // ─── Header ──────────────────────────────────────────────────────
//   Widget _buildHeader(BuildContext context, bool isDark, Map currentData) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1A237E), Color(0xFF1D4ED8), Color(0xFF0284C7)],
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(32),
//           bottomRight: Radius.circular(32),
//         ),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 52),
//           child: Column(children: [
//             // Top row
//             Row(children: [
//               // Exams button
//               GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ExamsDetailPage(
//                       monthName: monthsMap[selectedMonth]!,
//                       data: currentData.cast<String, dynamic>(),
//                       isDarkMode: isDark,
//                       isArabic: widget.isArabic,
//                     ),
//                   ),
//                 ),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(color: Colors.white.withOpacity(0.2)),
//                   ),
//                   child: Row(mainAxisSize: MainAxisSize.min, children: [
//                     const Icon(Icons.assignment_rounded,
//                         color: Colors.white, size: 16),
//                     const SizedBox(width: 6),
//                     Text(
//                       t("الامتحانات", "Exams"),
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12),
//                     ),
//                   ]),
//                 ),
//               ),
//               const Spacer(),
//               // Title
//               Column(
//                 crossAxisAlignment: widget.isArabic
//                     ? CrossAxisAlignment.end
//                     : CrossAxisAlignment.start,
//                 children: [
//                   Text(t("درجاتك", "Your Grades"),
//                       style:
//                           const TextStyle(color: Colors.white70, fontSize: 13)),
//                   const SizedBox(height: 3),
//                   Text(t("السجلات الأكاديمية", "Academic Records"),
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w800)),
//                 ],
//               ),
//             ]),

//             // Stats row
//             if (currentData['status'] == "released") ...[
//               const SizedBox(height: 20),
//               Row(children: [
//                 _headerStat(t("النسبة", "Grade"), currentData['percent'],
//                     const Color(0xFF60A5FA)),
//                 const SizedBox(width: 10),
//                 _headerStat(t("الترتيب", "Rank"), currentData['rankAr'],
//                     const Color(0xFFFBBF24)),
//                 const SizedBox(width: 10),
//                 _headerStat(t("الإجمالي", "Total"), currentData['total'],
//                     const Color(0xFF34D399)),
//               ]),
//             ],
//           ]),
//         ),
//       ),
//     );
//   }

//   Widget _headerStat(String label, String val, Color color) => Expanded(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1D4ED8).withOpacity(0.35),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.white.withOpacity(0.25)),
//           ),
//           child: Column(children: [
//             Text(val,
//                 style: TextStyle(
//                     color: color, fontWeight: FontWeight.w900, fontSize: 16)),
//             Text(label,
//                 style: const TextStyle(color: Colors.white70, fontSize: 10)),
//           ]),
//         ),
//       );

//   // ─── Profile Card ────────────────────────────────────────────────
//   Widget _buildProfileCard(Color cardColor, Color textColor, bool isDark) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
//             blurRadius: 20,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(children: [
//           Row(children: [
//             // Avatar with blue ring
//             // Container(
//             //   padding: const EdgeInsets.all(3),
//             //   decoration: BoxDecoration(
//             //     shape: BoxShape.circle,
//             //     border: Border.all(color: blue, width: 2.5),
//             //   ),
//             //   child: Container(
//             //     width: 62,
//             //     height: 62,
//             //     decoration: const BoxDecoration(shape: BoxShape.circle),
//             //     child: ClipOval(
//             //       child: widget.profileImage != null
//             //           ? (kIsWeb
//             //               ? Image.network(widget.profileImage!.path,
//             //                   fit: BoxFit.cover, width: 62, height: 62)
//             //               : Image.file(File(widget.profileImage!.path),
//             //                   fit: BoxFit.cover, width: 62, height: 62))
//             //           : Container(
//             //               decoration: const BoxDecoration(
//             //                 gradient: LinearGradient(
//             //                   colors: [primary, accent],
//             //                   begin: Alignment.topLeft,
//             //                   end: Alignment.bottomRight,
//             //                 ),
//             //               ),
//             //               child: const Center(
//             //                 child: Text("س",
//             //                     style: TextStyle(
//             //                         color: Colors.white,
//             //                         fontSize: 24,
//             //                         fontWeight: FontWeight.bold)),
//             //               ),
//             //             ),
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: widget.isArabic
//                     ? CrossAxisAlignment.end
//                     : CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.isArabic
//                         ? "سلمى أحمد محمد علي"
//                         : "Salma Ahmed Mohamed Ali",
//                     style: TextStyle(
//                         color: textColor,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w900),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     widget.isArabic
//                         ? "الأنظمة المدمجة والذكاء الاصطناعي"
//                         : "Embedded Systems & AI",
//                     style: TextStyle(
//                         color: accent.withOpacity(0.8),
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//           ]),
//           const SizedBox(height: 18),
//           Divider(color: primary.withOpacity(0.08), height: 1),
//           const SizedBox(height: 14),
//           _infoRow(Icons.badge_outlined, t("الرقم القومي", "National ID"),
//               "29901011234567", textColor),
//           const SizedBox(height: 10),
//           _infoRow(Icons.class_outlined, t("الفصل / اللاب", "Class / Lab"),
//               "3G / Lab.8 G.1", textColor),
//           const SizedBox(height: 10),
//           _infoRow(Icons.numbers_rounded, t("رقم الطالب", "Student ID"),
//               "11030", textColor),
//         ]),
//       ),
//     );
//   }

//   Widget _infoRow(IconData icon, String label, String value, Color textColor) {
//     final isAr = widget.isArabic;
//     return Row(
//       mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: isAr
//           ? [
//               Text(value,
//                   style: TextStyle(
//                       color: textColor,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13)),
//               const SizedBox(width: 5),
//               Text(":",
//                   style: TextStyle(
//                       color: textColor.withOpacity(0.3), fontSize: 13)),
//               const SizedBox(width: 2),
//               Text(label,
//                   style: TextStyle(
//                       color: textColor.withOpacity(0.45), fontSize: 12)),
//               const SizedBox(width: 10),
//               Container(
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                     color: primary.withOpacity(0.06),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Icon(icon, size: 15, color: primary.withOpacity(0.55)),
//               ),
//             ]
//           : [
//               Container(
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                     color: primary.withOpacity(0.06),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Icon(icon, size: 15, color: primary.withOpacity(0.55)),
//               ),
//               const SizedBox(width: 10),
//               Text(label,
//                   style: TextStyle(
//                       color: textColor.withOpacity(0.45), fontSize: 12)),
//               const SizedBox(width: 2),
//               Text(":",
//                   style: TextStyle(
//                       color: textColor.withOpacity(0.3), fontSize: 13)),
//               const SizedBox(width: 5),
//               Text(value,
//                   style: TextStyle(
//                       color: textColor,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13)),
//             ],
//     );
//   }

//   // ─── Month Picker ────────────────────────────────────────────────
//   Widget _buildMonthPicker(Color cardColor, Color textColor, bool isDark) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: primary.withOpacity(0.1)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: selectedMonth,
//           isExpanded: true,
//           dropdownColor: cardColor,
//           icon: Icon(Icons.keyboard_arrow_down_rounded, color: accent),
//           items: monthsMap.keys.map((m) {
//             final isSel = m == selectedMonth;
//             return DropdownMenuItem(
//               value: m,
//               child: Row(
//                 mainAxisAlignment: widget.isArabic
//                     ? MainAxisAlignment.end
//                     : MainAxisAlignment.start,
//                 children: [
//                   if (!widget.isArabic && isSel) ...[
//                     Container(
//                         width: 6,
//                         height: 6,
//                         decoration: const BoxDecoration(
//                             color: accent, shape: BoxShape.circle)),
//                     const SizedBox(width: 8),
//                   ],
//                   Text(monthsMap[m]!,
//                       style: TextStyle(
//                         color: isSel ? accent : textColor,
//                         fontWeight: isSel ? FontWeight.w900 : FontWeight.w600,
//                         fontSize: 14,
//                       )),
//                   if (widget.isArabic && isSel) ...[
//                     const SizedBox(width: 8),
//                     Container(
//                         width: 6,
//                         height: 6,
//                         decoration: const BoxDecoration(
//                             color: accent, shape: BoxShape.circle)),
//                   ],
//                 ],
//               ),
//             );
//           }).toList(),
//           onChanged: _changeMonth,
//         ),
//       ),
//     );
//   }

//   // ─── Stats Grid ──────────────────────────────────────────────────
//   Widget _buildStatsGrid(Map data, bool isDark) => Row(children: [
//         _statBox(t("النسبة", "Grade"), data['percent'], const Color(0xFF1565C0),
//             Icons.percent_rounded, isDark),
//         const SizedBox(width: 10),
//         _statBox(t("الترتيب", "Rank"), data['rankAr'], const Color(0xFFE65100),
//             Icons.emoji_events_rounded, isDark),
//         const SizedBox(width: 10),
//         _statBox(t("الإجمالي", "Total"), data['total'], const Color(0xFF1B5E20),
//             Icons.bar_chart_rounded, isDark),
//       ]);

//   Widget _statBox(
//           String lbl, String val, Color col, IconData icon, bool isDark) =>
//       Expanded(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//           decoration: BoxDecoration(
//             color: col.withOpacity(isDark ? 0.15 : 0.06),
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(color: col.withOpacity(0.2), width: 1.2),
//             boxShadow: [
//               BoxShadow(
//                   color: col.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4))
//             ],
//           ),
//           child: Column(children: [
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                   color: col.withOpacity(0.15), shape: BoxShape.circle),
//               child: Icon(icon, color: col, size: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(val,
//                 style: TextStyle(
//                     color: col, fontWeight: FontWeight.w900, fontSize: 14)),
//             const SizedBox(height: 2),
//             Text(lbl,
//                 style: TextStyle(
//                     fontSize: 10,
//                     color: col.withOpacity(0.8),
//                     fontWeight: FontWeight.w600)),
//           ]),
//         ),
//       );

//   // ─── Grades List ─────────────────────────────────────────────────
//   Widget _buildGradesList(
//       List grades, Color cardColor, Color textColor, bool isDark) {
//     final colors = [
//       const Color(0xFF1565C0),
//       const Color(0xFF6A1B9A),
//       const Color(0xFF00695C),
//       const Color(0xFFE65100),
//       const Color(0xFF283593),
//     ];
//     return Column(
//       children: List.generate(grades.length, (i) {
//         final g = grades[i];
//         final col = colors[i % colors.length];
//         final pct =
//             (int.tryParse(g['score']) ?? 0) / (int.tryParse(g['max']) ?? 1);

//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: col.withOpacity(0.1)),
//             boxShadow: [
//               BoxShadow(
//                   color: col.withOpacity(isDark ? 0.1 : 0.05),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4))
//             ],
//           ),
//           child: Column(children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: widget.isArabic
//                   ? [
//                       // Score badge (left in RTL)
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: col.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: col.withOpacity(0.25)),
//                         ),
//                         child: Text("${g['score']}/${g['max']}",
//                             style: TextStyle(
//                                 color: col,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 14)),
//                       ),
//                       // Subject (right in RTL)
//                       Row(children: [
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(g['label'],
//                                   style: TextStyle(
//                                       color: textColor,
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 14)),
//                               const SizedBox(height: 2),
//                               Row(children: [
//                                 Text(g['work'],
//                                     style: TextStyle(
//                                         color: col,
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.bold)),
//                                 const SizedBox(width: 4),
//                                 Text(t("أعمال السنة:", "Coursework:"),
//                                     style: TextStyle(
//                                         color: textColor.withOpacity(0.45),
//                                         fontSize: 11)),
//                               ]),
//                             ]),
//                         const SizedBox(width: 10),
//                         Text(g['icon'], style: const TextStyle(fontSize: 22)),
//                       ]),
//                     ]
//                   : [
//                       // Subject (left in LTR)
//                       Row(children: [
//                         Text(g['icon'], style: const TextStyle(fontSize: 22)),
//                         const SizedBox(width: 10),
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(g['label'],
//                                   style: TextStyle(
//                                       color: textColor,
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 14)),
//                               const SizedBox(height: 2),
//                               Row(children: [
//                                 Text("Coursework:",
//                                     style: TextStyle(
//                                         color: textColor.withOpacity(0.45),
//                                         fontSize: 11)),
//                                 const SizedBox(width: 4),
//                                 Text(g['work'],
//                                     style: TextStyle(
//                                         color: col,
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.bold)),
//                               ]),
//                             ]),
//                       ]),
//                       // Score badge (right in LTR)
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: col.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: col.withOpacity(0.25)),
//                         ),
//                         child: Text("${g['score']}/${g['max']}",
//                             style: TextStyle(
//                                 color: col,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 14)),
//                       ),
//                     ],
//             ),
//             const SizedBox(height: 12),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: LinearProgressIndicator(
//                 value: pct,
//                 minHeight: 6,
//                 backgroundColor: col.withOpacity(0.1),
//                 valueColor: AlwaysStoppedAnimation<Color>(col),
//               ),
//             ),
//           ]),
//         );
//       }),
//     );
//   }

//   // ─── Summary Card ────────────────────────────────────────────────
//   Widget _buildSummaryCard(bool isDark) => Container(
//         padding: const EdgeInsets.all(22),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//               colors: [Color(0xFF1A237E), Color(0xFF1D4ED8)],
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft),
//           borderRadius: BorderRadius.circular(22),
//           boxShadow: [
//             BoxShadow(
//                 color: primary.withOpacity(0.4),
//                 blurRadius: 24,
//                 offset: const Offset(0, 10))
//           ],
//         ),
//         child: Column(children: [
//           _summaryRow(t("إجمالي النظري", "Theory Total"), "374 / 400",
//               Icons.book_rounded),
//           const SizedBox(height: 12),
//           Container(
//               height: 1,
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                 Colors.transparent,
//                 Colors.white24,
//                 Colors.transparent
//               ]))),
//           const SizedBox(height: 12),
//           _summaryRow(t("إجمالي العملي", "Practical Total"), "295 / 300",
//               Icons.science_rounded),
//         ]),
//       );

//   Widget _summaryRow(String lbl, String val, IconData icon) =>
//       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         if (!widget.isArabic) ...[
//           Container(
//             width: 34,
//             height: 34,
//             decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Icon(icon, color: Colors.white, size: 18),
//           ),
//           const SizedBox(width: 10),
//           Text(lbl,
//               style: TextStyle(
//                   color: Colors.white.withOpacity(0.85),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14)),
//         ],
//         Text(val,
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w900,
//                 fontSize: 20)),
//         if (widget.isArabic) ...[
//           Row(children: [
//             Text(lbl,
//                 style: TextStyle(
//                     color: Colors.white.withOpacity(0.85),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14)),
//             const SizedBox(width: 10),
//             Container(
//               width: 34,
//               height: 34,
//               decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Icon(icon, color: Colors.white, size: 18),
//             ),
//           ]),
//         ],
//       ]);

//   // ─── Upcoming State ──────────────────────────────────────────────
//   Widget _buildUpcomingState(String? expected) => Container(
//         margin: const EdgeInsets.only(top: 10),
//         padding: const EdgeInsets.all(32),
//         decoration: BoxDecoration(
//           color: primary.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(color: primary.withOpacity(0.12)),
//         ),
//         child: Column(children: [
//           Container(
//             width: 76,
//             height: 76,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(colors: [
//                 primary.withOpacity(0.15),
//                 accent.withOpacity(0.15)
//               ]),
//               border: Border.all(color: primary.withOpacity(0.2)),
//             ),
//             child: const Icon(Icons.hourglass_top_rounded,
//                 color: primary, size: 36),
//           ),
//           const SizedBox(height: 16),
//           Text(t("النتيجة لم تصدر بعد", "Results Not Released Yet"),
//               style: const TextStyle(
//                   color: primary, fontSize: 16, fontWeight: FontWeight.w800)),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
//             decoration: BoxDecoration(
//               color: gold.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(30),
//               border: Border.all(color: gold.withOpacity(0.3)),
//             ),
//             child: Text(
//                 "${t('موعد الصدور المتوقع', 'Expected Release')}: $expected",
//                 style: const TextStyle(
//                     color: gold, fontWeight: FontWeight.bold, fontSize: 13)),
//           ),
//         ]),
//       );
// }

// // ══════════════════════════════════════════════════════════════════
// // ExamsDetailPage
// // ══════════════════════════════════════════════════════════════════
// class ExamsDetailPage extends StatelessWidget {
//   final String monthName;
//   final Map<String, dynamic> data;
//   final bool isDarkMode;
//   final bool isArabic;

//   const ExamsDetailPage({
//     super.key,
//     required this.monthName,
//     required this.data,
//     required this.isDarkMode,
//     required this.isArabic,
//   });

//   static const Color primary = Color(0xFF1A237E);
//   static const Color accent = Color(0xFF7C4DFF);
//   static const Color gold = Color(0xFFFFB300);

//   String t(String ar, String en) => isArabic ? ar : en;

//   @override
//   Widget build(BuildContext context) {
//     final hasExams = data['hasExams'] ?? false;
//     final cardColor = isDarkMode ? const Color(0xFF131929) : Colors.white;
//     final textColor = isDarkMode ? Colors.white : const Color(0xFF0D1333);

//     return Directionality(
//       textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor:
//             isDarkMode ? const Color(0xFF090E1A) : const Color(0xFFF0F4FF),
//         body: Column(children: [
//           // Header
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF1A237E),
//                   Color(0xFF1D4ED8),
//                   Color(0xFF7C4DFF)
//                 ],
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//               ),
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(28),
//                   bottomRight: Radius.circular(28)),
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
//                 child: Row(children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Icon(
//                         isArabic
//                             ? Icons.arrow_back_ios_new_rounded
//                             : Icons.arrow_forward_ios_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Text("${t('تفاصيل', 'Details of')} $monthName",
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17)),
//                   const Spacer(),
//                   const SizedBox(width: 38),
//                 ]),
//               ),
//             ),
//           ),

//           // Body
//           Expanded(
//             child: hasExams
//                 ? SingleChildScrollView(
//                     padding: const EdgeInsets.all(20),
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       crossAxisAlignment: isArabic
//                           ? CrossAxisAlignment.start
//                           : CrossAxisAlignment.start,
//                       children: [
//                         _sectionHeader(
//                             "📋 ${t('جدول امتحانات الشهر', 'Monthly Exam Schedule')}",
//                             primary),
//                         const SizedBox(height: 14),
//                         _buildExamsTable(data['exams'], cardColor, textColor),
//                         const SizedBox(height: 26),
//                         _sectionHeader(
//                             "⚡ ${t('مراجعات الشهر', 'Monthly Revisions')}",
//                             accent),
//                         const SizedBox(height: 14),
//                         ...(data['revisions'] as List)
//                             .map((r) => _revisionCard(r, cardColor, textColor))
//                             .toList(),
//                       ],
//                     ),
//                   )
//                 : _buildNoExamsState(cardColor, textColor),
//           ),
//         ]),
//       ),
//     );
//   }

//   Widget _sectionHeader(String title, Color color) => Row(
//         textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
//         children: [
//           Container(
//               width: 4,
//               height: 22,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [color, color.withOpacity(0.5)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter),
//                 borderRadius: BorderRadius.circular(4),
//               )),
//           const SizedBox(width: 10),
//           Text(title,
//               style: TextStyle(
//                   fontSize: 16, fontWeight: FontWeight.bold, color: color)),
//         ],
//       );

//   Widget _buildExamsTable(List exams, Color cardColor, Color textColor) {
//     return Container(
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: primary.withOpacity(0.1)),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Column(children: [
//         // Table header
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [Color(0xFF1A237E), Color(0xFF7C4DFF)],
//                 begin: Alignment.centerRight,
//                 end: Alignment.centerLeft),
//           ),
//           child: Row(children: [
//             Expanded(
//                 child: Text(t("التاريخ", "Date"),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12))),
//             Expanded(
//                 flex: 3,
//                 child: Text(t("المواد", "Subjects"),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12))),
//             Expanded(
//                 child: Text(t("اليوم", "Day"),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12))),
//           ]),
//         ),
//         ...List.generate(exams.length, (i) {
//           final e = exams[i];
//           return Container(
//             padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//             decoration: BoxDecoration(
//               color:
//                   i % 2 == 0 ? primary.withOpacity(0.03) : Colors.transparent,
//               border: i < exams.length - 1
//                   ? Border(bottom: BorderSide(color: primary.withOpacity(0.06)))
//                   : null,
//             ),
//             child: Row(children: [
//               Expanded(
//                   child: Text(e['date'],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: textColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12))),
//               Expanded(
//                   flex: 3,
//                   child: Text(e['sub'],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: textColor, fontSize: 12))),
//               Expanded(
//                   child: Text(e['day'],
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           color: accent,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12))),
//             ]),
//           );
//         }),
//       ]),
//     );
//   }

//   Widget _revisionCard(dynamic r, Color cardColor, Color textColor) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: gold.withOpacity(0.15)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)
//         ],
//       ),
//       child: Row(
//         textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//             decoration: BoxDecoration(
//               color: Colors.green.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.green.withOpacity(0.25)),
//             ),
//             child: Text(r['price'],
//                 style: const TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.w900,
//                     fontSize: 13)),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//               child: Column(
//             crossAxisAlignment:
//                 isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//             children: [
//               Text(r['name'],
//                   style: TextStyle(
//                       color: textColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13)),
//               const SizedBox(height: 3),
//               Text("${r['day']} — ${r['time']}",
//                   style: TextStyle(
//                       color: textColor.withOpacity(0.45), fontSize: 11)),
//             ],
//           )),
//           const SizedBox(width: 10),
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle, color: gold.withOpacity(0.1)),
//             child: const Icon(Icons.star_rounded, color: gold, size: 20),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoExamsState(Color cardColor, Color textColor) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                   colors: [primary.withOpacity(0.1), accent.withOpacity(0.1)]),
//               border: Border.all(color: primary.withOpacity(0.2)),
//             ),
//             child:
//                 const Icon(Icons.event_note_rounded, size: 44, color: primary),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             "${t('جداول شهر', 'Schedule for')} $monthName ${t('لم تنزل بعد', 'not released yet')}",
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//                 fontSize: 17, fontWeight: FontWeight.w800, color: primary),
//           ),
//           const SizedBox(height: 24),
//           _dateInfoTile("📅 ${t('موعد نزول الجدول', 'Schedule Release Date')}",
//               data['nextExam'] ?? "—", cardColor, textColor),
//           const SizedBox(height: 10),
//           _dateInfoTile(
//               "📝 ${t('موعد نزول المراجعات', 'Revisions Release Date')}",
//               data['nextRev'] ?? "—",
//               cardColor,
//               textColor),
//         ]),
//       ),
//     );
//   }

//   Widget _dateInfoTile(
//       String title, String value, Color cardColor, Color textColor) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: gold.withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment:
//             isArabic ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
//         textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
//         children: [
//           Text(value,
//               style: const TextStyle(
//                   color: primary, fontWeight: FontWeight.w900, fontSize: 15)),
//           const SizedBox(width: 12),
//           Text(title,
//               style: TextStyle(
//                   color: textColor, fontWeight: FontWeight.w600, fontSize: 13)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}