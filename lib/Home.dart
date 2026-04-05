// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class HomePage extends StatefulWidget {
//   final Function(String) onNavigate;
//   final bool isArabic;
//   final XFile? profileImage;

//   const HomePage({
//     super.key,
//     required this.onNavigate,
//     required this.isArabic,
//     this.profileImage,
//   });

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnim;

//   // Teacher evaluations of the student (read-only, set by teachers)
//   final List<Map<String, dynamic>> teacherRatings = [
//     {
//       'nameAr': 'أ. محمد السيد',
//       'nameEn': 'Mr. Mohamed',
//       'subjectAr': 'الرياضيات',
//       'subjectEn': 'Mathematics',
//       'rating': 4,
//       'commentAr': 'الطالبة متميزة ومجتهدة، تحتاج مزيد من التركيز في الهندسة.',
//       'commentEn': 'Excellent student, needs more focus on geometry.',
//       'icon': '📐',
//       'color': Color(0xFF4F46E5),
//     },
//     {
//       'nameAr': 'أ. سارة أحمد',
//       'nameEn': 'Ms. Sara',
//       'subjectAr': 'الفيزياء',
//       'subjectEn': 'Physics',
//       'rating': 3,
//       'commentAr': 'أداء جيد، لكن يجب الاهتمام بحل المسائل العملية.',
//       'commentEn': 'Good performance, but needs to practice problem solving.',
//       'icon': '⚛️',
//       'color': Color(0xFF0284C7),
//     },
//     {
//       'nameAr': 'أ. خالد عمر',
//       'nameEn': 'Mr. Khaled',
//       'subjectAr': 'البرمجة',
//       'subjectEn': 'Programming',
//       'rating': 5,
//       'commentAr': 'ممتازة جداً، إبداع واضح في المشاريع البرمجية.',
//       'commentEn': 'Outstanding! Shows great creativity in coding projects.',
//       'icon': '💻',
//       'color': Color(0xFF10B981),
//     },
//     {
//       'nameAr': 'أ. منى حسن',
//       'nameEn': 'Ms. Mona',
//       'subjectAr': 'اللغة العربية',
//       'subjectEn': 'Arabic',
//       'rating': 4,
//       'commentAr': 'تعبير راقٍ وأسلوب متميز، استمري على نفس المستوى.',
//       'commentEn': 'Elegant writing style, keep up the great work.',
//       'icon': '📖',
//       'color': Color(0xFFEC4899),
//     },
//     {
//       'nameAr': 'أ. طارق علي',
//       'nameEn': 'Mr. Tarek',
//       'subjectAr': 'الكيمياء',
//       'subjectEn': 'Chemistry',
//       'rating': 3,
//       'commentAr': 'تحتاج مراجعة المعادلات الكيميائية بشكل أعمق.',
//       'commentEn': 'Needs deeper review of chemical equations.',
//       'icon': '🧪',
//       'color': Color(0xFFF59E0B),
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 700));
//     _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
//     final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
//     final bg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF0F4FF);

//     return Scaffold(
//       backgroundColor: bg,
//       body: FadeTransition(
//         opacity: _fadeAnim,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(isDark),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildGradeBadge(isDark, cardColor, textColor),
//                     const SizedBox(height: 24),

//                     _buildSectionLabel(
//                         widget.isArabic ? "جدولك" : "Your Schedule", textColor),
//                     const SizedBox(height: 12),
//                     _buildScheduleButton(isDark),

//                     const SizedBox(height: 24),
//                     _buildSectionLabel(
//                         widget.isArabic ? "مصاريفك" : "Your Fees", textColor),
//                     const SizedBox(height: 12),
//                     _buildFeesCard(isDark, cardColor, textColor),

//                     const SizedBox(height: 24),
//                     _buildSectionLabel(
//                         widget.isArabic ? "الواجبات" : "Homework", textColor),
//                     const SizedBox(height: 12),
//                     _buildHomeworkCard(isDark, cardColor, textColor),

//                     const SizedBox(height: 24),
//                     // ── Teacher Ratings Section ──
//                     _buildSectionLabel(
//                         widget.isArabic
//                             ? "⭐ تقييمات المدرسين"
//                             : "⭐ Teacher Ratings",
//                         textColor),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.isArabic
//                           ? "اضغط على أي مدرس لتقييمه"
//                           : "Tap a teacher to rate them",
//                       style: TextStyle(
//                           fontSize: 12, color: textColor.withOpacity(0.45)),
//                     ),
//                     const SizedBox(height: 12),
//                     _buildTeacherRatings(isDark, cardColor, textColor),

//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTeacherRatings(bool isDark, Color cardColor, Color textColor) {
//     return Column(
//       children: List.generate(teacherRatings.length, (index) {
//         final teacher = teacherRatings[index];
//         final color = teacher['color'] as Color;
//         final rating = teacher['rating'] as int;
//         final comment = widget.isArabic
//             ? teacher['commentAr'] as String
//             : teacher['commentEn'] as String;

//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: color.withOpacity(0.25), width: 1.5),
//             boxShadow: [
//               BoxShadow(
//                   color: color.withOpacity(0.06),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4))
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(children: [
//                 // Subject icon
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.10),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: Center(
//                       child: Text(teacher['icon'] as String,
//                           style: const TextStyle(fontSize: 24))),
//                 ),
//                 const SizedBox(width: 12),
//                 // Name + subject
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.isArabic
//                             ? teacher['nameAr'] as String
//                             : teacher['nameEn'] as String,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w800,
//                             fontSize: 14,
//                             color: textColor),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         widget.isArabic
//                             ? teacher['subjectAr'] as String
//                             : teacher['subjectEn'] as String,
//                         style: TextStyle(
//                             color: color,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Stars (read-only)
//                 Row(
//                   children: List.generate(
//                       5,
//                       (i) => Icon(
//                             i < rating
//                                 ? Icons.star_rounded
//                                 : Icons.star_outline_rounded,
//                             color: Colors.amber,
//                             size: 16,
//                           )),
//                 ),
//               ]),
//               const SizedBox(height: 10),
//               // Teacher comment
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.07),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.format_quote_rounded, color: color, size: 16),
//                     const SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         comment,
//                         style: TextStyle(
//                             fontSize: 12.5,
//                             color: textColor.withOpacity(0.75),
//                             height: 1.5),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildHeader(bool isDark) {
//     return Container(
//       width: double.infinity,
//       height: 220,
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
//       child: Stack(
//         children: [
//           Positioned(
//               top: -30,
//               right: -30,
//               child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white.withOpacity(0.06)))),
//           Positioned(
//               bottom: -20,
//               left: -20,
//               child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white.withOpacity(0.04)))),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: 56,
//                         height: 56,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                               color: Colors.white.withOpacity(0.5), width: 2),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 blurRadius: 12)
//                           ],
//                         ),
//                         child: ClipOval(
//                           child: widget.profileImage != null
//                               ? (kIsWeb
//                                   ? Image.network(widget.profileImage!.path,
//                                       fit: BoxFit.cover)
//                                   : Image.file(File(widget.profileImage!.path),
//                                       fit: BoxFit.cover))
//                               : Container(
//                                   color: Colors.white.withOpacity(0.15),
//                                   child: const Center(
//                                       child: Text("👤",
//                                           style: TextStyle(fontSize: 28))),
//                                 ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.15),
//                           borderRadius: BorderRadius.circular(30),
//                           border:
//                               Border.all(color: Colors.white.withOpacity(0.2)),
//                         ),
//                         child: Row(children: [
//                           Container(
//                               width: 8,
//                               height: 8,
//                               decoration: const BoxDecoration(
//                                   color: Color(0xFF10B981),
//                                   shape: BoxShape.circle)),
//                           const SizedBox(width: 7),
//                           Text(widget.isArabic ? "نشط" : "Active",
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600)),
//                         ]),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Text(widget.isArabic ? "صباح الخير ✨" : "Good Morning ✨",
//                       style: TextStyle(
//                           color: Colors.white.withOpacity(0.7), fontSize: 14)),
//                   const SizedBox(height: 4),
//                   Text(widget.isArabic ? "مرحباً، سلمى" : "Welcome, Salma",
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 26,
//                           fontWeight: FontWeight.w800,
//                           letterSpacing: 0.3)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionLabel(String text, Color textColor) => Text(text,
//       style: TextStyle(
//           fontSize: 17,
//           fontWeight: FontWeight.w800,
//           color: textColor,
//           letterSpacing: 0.2));

//   Widget _buildGradeBadge(bool isDark, Color cardColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: const Color(0xFF1D4ED8).withOpacity(0.12)),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 12,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                   colors: [Color(0xFF10B981), Color(0xFF059669)]),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Text("3",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16)),
//           ),
//           Text(
//               widget.isArabic
//                   ? "الثالث الثانوي • الأنظمة المدمجة"
//                   : "Third Secondary • AI Systems",
//               style: TextStyle(
//                   fontSize: 14, fontWeight: FontWeight.w700, color: textColor)),
//         ],
//       ),
//     );
//   }

//   Widget _buildScheduleButton(bool isDark) {
//     final textColor = isDark ? Colors.white : const Color(0xFF0D1333);
//     const accentColor = Color(0xFF4F46E5);

//     return GestureDetector(
//       onTap: () => widget.onNavigate("schedule"),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isDark
//                 ? [
//                     const Color(0xFF1e1b4b).withOpacity(0.8),
//                     const Color(0xFF1E293B)
//                   ]
//                 : [const Color(0xFFEEF2FF), Colors.white],
//           ),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//                 color: accentColor.withOpacity(0.08),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Row(children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: accentColor.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: const Icon(Icons.calendar_today_rounded,
//                 color: accentColor, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                 Text(widget.isArabic ? "الجدول الدراسي" : "School Schedule",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                         color: textColor,
//                         fontSize: 15)),
//                 Text(
//                     widget.isArabic
//                         ? "عرض الحصص والمواعيد اليومية"
//                         : "View daily classes & timing",
//                     style: TextStyle(
//                         color: textColor.withOpacity(0.5), fontSize: 12)),
//               ])),
//           Icon(Icons.arrow_forward_ios_rounded, color: accentColor, size: 16),
//         ]),
//       ),
//     );
//   }

//   Widget _buildFeesCard(bool isDark, Color cardColor, Color textColor) {
//     return GestureDetector(
//       onTap: () => widget.onNavigate('fees'),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isDark
//                 ? [
//                     const Color(0xFF052e16).withOpacity(0.8),
//                     const Color(0xFF1E293B)
//                   ]
//                 : [const Color(0xFFf0fdf4), Colors.white],
//           ),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//               color: const Color(0xFF10B981).withOpacity(0.3), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//                 color: const Color(0xFF10B981).withOpacity(0.08),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Row(children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF10B981).withOpacity(0.12),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: const Icon(Icons.account_balance_wallet_rounded,
//                 color: Color(0xFF10B981), size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                 Text(widget.isArabic ? "تفاصيل المصروفات" : "Fees Details",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                         color: textColor,
//                         fontSize: 15)),
//                 Text(
//                     widget.isArabic
//                         ? "اضغط لعرض التفاصيل"
//                         : "Tap to view details",
//                     style: TextStyle(
//                         color: textColor.withOpacity(0.5), fontSize: 12)),
//               ])),
//           Icon(Icons.arrow_forward_ios_rounded,
//               color: const Color(0xFF10B981), size: 16),
//         ]),
//       ),
//     );
//   }

//   Widget _buildHomeworkCard(bool isDark, Color cardColor, Color textColor) {
//     return GestureDetector(
//       onTap: () => widget.onNavigate('homework'),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isDark
//                 ? [
//                     const Color(0xFF1e1b4b).withOpacity(0.8),
//                     const Color(0xFF1E293B)
//                   ]
//                 : [const Color(0xFFf5f3ff), Colors.white],
//           ),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//               color: const Color(0xFF6366F1).withOpacity(0.3), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//                 color: const Color(0xFF6366F1).withOpacity(0.08),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Row(children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF6366F1).withOpacity(0.12),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: const Text("📚", style: TextStyle(fontSize: 22)),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                 Text(widget.isArabic ? "الواجبات المدرسية" : "School Homework",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                         color: textColor,
//                         fontSize: 15)),
//                 Text(
//                     widget.isArabic
//                         ? "تابع واجبات الميكانيكا والبرمجة"
//                         : "Check your homework",
//                     style: TextStyle(
//                         color: textColor.withOpacity(0.5), fontSize: 12)),
//               ])),
//           Icon(Icons.arrow_forward_ios_rounded,
//               color: const Color(0xFF6366F1), size: 16),
//         ]),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}