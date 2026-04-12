// final subjects = [
//       {
//         "name": isAr ? "ميكانيكا" : "Mechanics",
//         "time": "07:30 - 11:00",
//         "room": isAr ? "قاعة 3" : "Hall 3",
//         "color": const Color(0xFF3B82F6),
//         "emoji": "⚙️",
//       },
//       {
//         "name": isAr ? "لغة إنجليزية" : "English Language",
//         "time": "07:30 - 11:00",
//         "room": isAr ? "قاعة 3" : "Hall 3",
//         "color": const Color(0xFF6366F1),
//         "emoji": "📖",
//       },
//       {
//         "name": isAr ? "مشروعات برمجية" : "Software Projects",
//         "time": "07:30 - 11:00",
//         "room": isAr ? "قاعة 3" : "Hall 3",
//         "color": const Color(0xFF10B981),
//         "emoji": "💻",
//       },
//       {
//         "name": isAr ? "تكنولوجيا مقايسات" : "Estimates Tech",
//         "time": "07:30 - 11:00",
//         "room": isAr ? "قاعة 3" : "Hall 3",
//         "color": const Color(0xFFF59E0B),
//         "emoji": "🔬",
//       },
//       {
//         "name": isAr ? "تدريب عملي" : "Practical Training",
//         "time": "07:30 - 09:30",
//         "room": isAr ? "قاعة 3" : "Hall 3",
//         "color": const Color(0xFFEC4899),
//         "emoji": "🧪",
//       },
//     ];

//     final exams = [
//       {
//         "name": isAr ? "امتحان شهر أكتوبر" : "October Exam",
//         "date": isAr ? "26 أكتوبر" : "Oct 26",
//         "color": const Color(0xFFF59E0B),
//         "icon": Icons.calendar_month_rounded,
//       },
//       {
//         "name": isAr ? "امتحان شهر نوفمبر" : "November Exam",
//         "date": isAr ? "23 نوفمبر" : "Nov 23",
//         "color": const Color(0xFF6366F1),
//         "icon": Icons.calendar_month_rounded,
//       },
//       {
//         "name": isAr ? "امتحان نصف العام" : "Mid-Year Exam",
//         "date": isAr ? "10 يناير" : "Jan 10",
//         "color": const Color(0xFFEF4444),
//         "icon": event_rounded,
//       },
//       {
//         "name": isAr ? "امتحان نهاية العام" : "Final Exam",
//         "date": isAr ? "20 يونيو" : "Jun 20",
//         "color": const Color(0xFF10B981),
//         "icon": Icons.school_rounded,
//       },
//     ];



// Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: color.withOpacity(0.15),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.07),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             // Color bar
//             Container(
//               width: 4,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),

//             const SizedBox(width: 14),

//             // Emoji circle
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Center(
//                 child: Text(
//                   s['emoji'] as String? ?? '❓',
//                   style: const TextStyle(fontSize: 22),
//                 ),
//               ),
//             ),

//             const SizedBox(width: 14),

//             // Subject info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     s['name'] as String? ?? 'Unknown',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 15,
//                       color: textColor,
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   Row(
//                     children: [
//                       Icon(
//                         Icons.access_time_rounded,
//                         size: 13,
//                         color: textColor.withOpacity(0.45),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         s['time'] as String? ?? 'N/A',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: textColor.withOpacity(0.55),
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       Icon(
//                         Icons.location_on_rounded,
//                         size: 13,
//                         color: textColor.withOpacity(0.45),
//                       ),
//                       const SizedBox(width: 4),

//                       Expanded(
//                         child: Text(
//                           s['room'] as String? ?? 'N/A',
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: textColor.withOpacity(0.55),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 10),

//             // Badge
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 6,
//               ),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 s['badge'] as String? ?? 'N/A',
//                 style: TextStyle(
//                   color: color,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 11,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );


//     //-----------------------------------------------------------------------------


  //     Widget _buildExamCard(Map e, Color cardColor, Color textColor, bool isDark) {
  //   final color = e['color'] as Color;
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: cardColor,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: color.withOpacity(0.2)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: color.withOpacity(0.06),
  //           blurRadius: 10,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  //           decoration: BoxDecoration(
  //             color: color.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(14),
  //             border: Border.all(color: color.withOpacity(0.2)),
  //           ),
  //           child: Column(
  //             children: [
  //               Icon(e['icon'] as IconData, color: color, size: 18),
  //               const SizedBox(height: 4),
  //               Text(
  //                 e['date'] as String,
  //                 style: TextStyle(
  //                   color: color,
  //                   fontWeight: FontWeight.w900,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: Text(
  //             e['name'] as String,
  //             style: TextStyle(
  //               fontWeight: FontWeight.w700,
  //               color: textColor,
  //               fontSize: 15,
  //             ),
  //           ),
  //         ),
  //         // السهم اتشال من هنا ✅
  //         // Container(
  //         //   width: 32,
  //         //   height: 32,
  //         //   decoration: BoxDecoration(
  //         //       color: color.withOpacity(0.1), shape: BoxShape.circle),
  //         //   child: Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
  //         // ),
  //       ],
  //     ),
  //   );
  // }